sseg segment para stack 'stack'
         db 64 dup ( 'STACK' )
sseg ends
dseg segment para public 'data'
    is_valid        db 1
    value           dw 0
    my_number       dw -96
    temp_value      dw 0
    is_minus        dw 0
    input_prompt    db 0dh, 0ah,'enter number in range of -32767 to 32767: $'
    output          db 0dh, 0ah, 'output: $'
    input_error_msg db 0dh, 0ah, 'the number you entered is too large$'
    minus_error_msg db 0dh, 0ah, 'the result of  is less than -32767$'
    wrong_char_msg  db 0dh, 0ah, 'wrong character$'
    empty_input_msg db 0dh, 0ah, 'empty input$'
dseg ends
cseg segment para public 'code'
  
main_proc proc
                 assume cs: cseg, ds: dseg, ss: sseg
                 push   ds
                 xor    ax, ax                          ; обнулення
                 push   ax
                 mov    ax, dseg
                 mov    ds, ax
    main_loop:   
                 call   read_number
                 call   minus_96
                 cmp    is_valid,1
                 jne    not_equal                       ; перейти якщо не дорівнює
                 jmp    end_if
    not_equal:   
                 xor    ax, ax
                 mov    value, ax
                 mov    temp_value, ax
                 mov    is_minus, ax
                 mov    is_valid, 1
                 jmp    main_loop
    end_if:      
                 call   print_number
                 jmp    main_loop
    finally:     
                 mov    ah, 4ch
                 int    21h                             ; переривання, завершення програми
main_proc endp


minus_96 proc
                 mov    ax, my_number
                 add    value, ax
                 jo     minus_error                     ; переходить на помилкук якщо відбулось переповненя
                 ret
    
    minus_error: 
                 mov    is_valid, 0
                 lea    dx, minus_error_msg
                 mov    ah, 09h                         ; копіює значення в регістр, вказщує на функцію що виводить рядок
                 int    21h                             ; викликає цю функцію
                 ret
minus_96 endp

read_number proc
                 xor    ax, ax                          ; обнулення
                 mov    value, ax                       ; обнулення
                 mov    temp_value, ax                  ; обнулення
                 mov    is_minus, ax                    ; обнулення
                 lea    dx, input_prompt                ; завантажує адресу в dx
                 mov    ah, 09h
                 int    21h
                 mov    bx, 10                          ; буде використовуватись для множення
                 mov    cx, 5                           ; буде використовуватись для контролю циклу
    read_loop:   
                 xor    ax, ax
                 mov    ah, 01h                         ; читання символу з клави
                 int    21h
                 cmp    al, 13                          ; якщо натиснено ентер(ASCII-код 13) - зупинка
                 je     stop

                 cmp    al, 48                          ; якщо введено число
                 jl     check_sign                      ; перейти якщо код символу менше 48 (що відповідає ‘0’)
                 cmp    al, 57
                 ja     wrong_char                      ; перейти якщо код символу більше 57 (що відповідає ‘9’)
                 
                 sub    al, '0'                         ; перетворення кода в число
                 sub    ah, ah
                 mov    temp_value, ax
                 
                 mov    ax, value
                 imul   bx                              ; зсув в ліво на один (множення на 10)
                 jo     input_error                     ; якщо переповнення
                 add    ax, temp_value
                 jo     input_error
                 mov    value, ax

                 loop   read_loop                       ; для проходження по циклу поки сх не буде 0
                 cmp    is_minus, 1
                 je     make_minus
                 ret
    stop:        
                 cmp    cx, 5
                 je     empty_input
                 mov    cx, 0
                 cmp    is_minus, 1
                 je     make_minus
                 ret
    make_minus:  
                 neg    value
                 ret
    check_sign:  
                 cmp    al, '-'
                 jne    wrong_char
                 cmp    cx, 5
                 jne    wrong_char
                 inc    is_minus
                 cmp    is_minus, 2                     ; якщо 2 мінуси
                 jne    read_loop
                 jmp    wrong_char
    input_error: 
                 mov    is_valid, 0
                 lea    dx, input_error_msg
                 mov    ah, 09h
                 int    21h
                 jmp    fin
    wrong_char:  
                 mov    is_valid, 0
                 lea    dx, wrong_char_msg
                 mov    ah, 09h
                 int    21h
                 jmp    fin
    empty_input: 
                 mov    is_valid, 0
                 lea    dx, empty_input_msg
                 mov    ah, 09h
                 int    21h
    fin:         ret
read_number endp

print_number proc
                 lea    dx, output                      ; виведення повідомлення
                 mov    ah, 09h
                 int    21h
    
                 mov    bx, value
                 or     bx, bx                          ; встановлення Sign Flag для перевірки від'ємності
                 jns    positive                        ; перехід бо додатній
                 mov    al, '-'
                 int    29h                             ; вивести мінус
                 neg    bx
    positive:    
                 mov    ax, bx
                 xor    cx, cx
                 mov    bx, 10
    transform:                                          ; перетворення числа в рядок
                 xor    dx, dx
                 div    bx
                 add    dl, '0'
                 push   dx
                 inc    cx
                 test   ax, ax                          ;=0
                 jnz    transform
    print:       
                 pop    ax                              ; виведення цифр зі стеку
                 int    29h
                 loop   print
                 ret
print_number endp
cseg ends
end main_proc
