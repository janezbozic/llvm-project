# RUN: llvm-mc -filetype=obj -triple=wasm32-unknown-unknown %s -o %t1.o

## Check that %t1.o contains undefined symbol undef.
# RUN: not wasm-ld %t1.o -o /dev/null 2>&1 | \
# RUN:   FileCheck -check-prefix=ERRUND %s
# ERRUND: error: {{.*}}1.o: undefined symbol: undef

## report-all is the default one. Check that we get the same error
# RUN: not wasm-ld %t1.o -o /dev/null --unresolved-symbols=report-all 2>&1 | \
# RUN:   FileCheck -check-prefix=ERRUND %s

## Error out if unknown option value was set.
# RUN: not wasm-ld %t1.o -o /dev/null --unresolved-symbols=xxx 2>&1 | \
# RUN:   FileCheck -check-prefix=ERR1 %s
# ERR1: unknown --unresolved-symbols value: xxx
## Check alias.
# RUN: not wasm-ld %t1.o -o /dev/null --unresolved-symbols xxx 2>&1 | \
# RUN:   FileCheck -check-prefix=ERR1 %s

## Ignore all should not produce error and should not produce
# any imports.  It should create a stub function in the place of the missing
# function symbol.
# RUN: wasm-ld %t1.o -o %t2.wasm --unresolved-symbols=ignore-all
# RUN: obj2yaml %t2.wasm | FileCheck -check-prefix=IGNORE %s
# IGNORE-NOT: - Type:            IMPORT
# IGNORE-NOT: - Type:            ELEM
#
#      IGNORE:  - Type:            CODE
# IGNORE-NEXT:    Functions:
# IGNORE-NEXT:      - Index:           0
# IGNORE-NEXT:        Locals:          []
# IGNORE-NEXT:        Body:            000B
# IGNORE-NEXT:      - Index:           1
# IGNORE-NEXT:        Locals:          []
# IGNORE-NEXT:        Body:            1080808080001082808080001083808080000B
# IGNORE-NEXT:      - Index:           2
# IGNORE-NEXT:        Locals:          []
# IGNORE-NEXT:        Body:            4180808080000F0B
# IGNORE-NEXT:      - Index:           3
# IGNORE-NEXT:        Locals:          []
# IGNORE-NEXT:        Body:            4180808080000F0B
#
#      IGNORE:  - Type:            CUSTOM
# IGNORE-NEXT:    Name:            name
# IGNORE-NEXT:    FunctionNames:
# IGNORE-NEXT:      - Index:           0
# IGNORE-NEXT:        Name:            undefined
# IGNORE-NEXT:      - Index:           1
# IGNORE-NEXT:        Name:            _start
# IGNORE-NEXT:      - Index:           2
# IGNORE-NEXT:        Name:            get_data_addr
# IGNORE-NEXT:      - Index:           3
# IGNORE-NEXT:        Name:            get_func_addr

## import-functions should not produce errors and should resolve in
# imports for the missing functions but not the missing data symbols.
# `--allow-undefined` should behave exactly the same.
# RUN: wasm-ld %t1.o -o %t3.wasm --unresolved-symbols=import-functions
# RUN: obj2yaml %t3.wasm | FileCheck -check-prefix=IMPORT %s
#      IMPORT:  - Type:            IMPORT
# IMPORT-NEXT:    Imports:
# IMPORT-NEXT:      - Module:          env
# IMPORT-NEXT:        Field:           undef
# IMPORT-NEXT:        Kind:            FUNCTION
# IMPORT-NEXT:        SigIndex:        0
# IMPORT-NEXT:  - Type:            FUNCTION

## Do not report undefines if linking relocatable.
# RUN: wasm-ld -r %t1.o -o %t4.wasm --unresolved-symbols=report-all
# RUN: llvm-readobj %t4.wasm > /dev/null 2>&1

.globl _start
_start:
    .functype _start () -> ()
    call undef
    call get_data_addr
    call get_func_addr
    end_function

.globl get_data_addr
get_data_addr:
    .functype get_data_addr () -> (i32)
    i32.const undef_data
    return
    end_function

.globl get_func_addr
get_func_addr:
    .functype get_func_addr () -> (i32)
    i32.const undef
    return
    end_function

.functype undef () -> ()
