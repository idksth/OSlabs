        .file   "hello.c"           // Название файла на языке С               
        .text                                             
        .globl  fib                 // Объявление имени fib глобальным                    
        .type   fib, @function      // Определение типа fib                       
fib:                                // Функция для числа Фибоначчи                    
.LFB0:                                                     
        .cfi_startproc              // Начало функции                       
        pushq   %rbp                   и определение типов                  
        .cfi_def_cfa_offset 16         (функции и параметра n)                       
        .cfi_offset 6, -16                                 
        xorl    %ebp, %ebp                                 
        pushq   %rbx                                       
        .cfi_def_cfa_offset 24                             
        .cfi_offset 3, -24                                
        leal    -1(%rdi), %ebx                             
        pushq   %rcx                                       
        .cfi_def_cfa_offset 32                             
.L3:                                                       
        cmpl    $1, %ebx            // Сравнение 1 и регистра ebx (в ebx находится переменная n)                      
        jbe     .L5                 // Если 1 <= ebx, тогда идет переход на метку L5                      
        movl    %ebx, %edi                              
        subl    $2, %ebx            // Здесь и выше - условие if (n==1 || n==2)                    
        call    fib                 // Рекурсивный вызов функции fib                     
        addl    %eax, %ebp                                 
        jmp     .L3                 // Переходим в начало данной метки (рекурсия)                       
.L5:                                                       
        leal    1(%rbp), %eax       // В метке L5                        
        popq    %rdx                   находится код                     
        .cfi_def_cfa_offset 24         для исполнения                    
        popq    %rbx                   return 1                     
        .cfi_def_cfa_offset 16                             
        popq    %rbp                                       
        .cfi_def_cfa_offset 8                              
        ret                                                
        .cfi_endproc                                       
.LFE0:                                                     
        .size   fib, .-fib                                 
        .section        .rodata.str1.1,"aMS",@progbits,1   
.LC0:                                                      
        .string "n = "            // Параметр для метода printf  
.LC1:                                                      
        .string "%d"              // Параметр для метода printf                         
.LC2:                                                      
        .string "%d "             // Параметр для метода scanf                          
        .section        .text.startup,"ax",@progbits       
        .globl  main              // Обьявление main глобальным именем                         
        .type   main, @function   // Определение типа main                           
main:                                                      
.LFB1:                                                     
        .cfi_startproc            // Начало функции                         
        pushq   %rbp                                       
        .cfi_def_cfa_offset 16                             
        .cfi_offset 6, -16                                 
        leaq    .LC0(%rip), %rdi  // Определение параметра "n = " для printf                          
        leaq    .LC2(%rip), %rbp  // Определение параметров ("%d" для scanf                         
        pushq   %rbx                                       
        .cfi_def_cfa_offset 24                             
        .cfi_offset 3, -24                                 
        movl    $1, %ebx                                   
        subq    $24, %rsp
        .cfi_def_cfa_offset 48                             
        movq    %fs:40, %rax                               
        movq    %rax, 8(%rsp)                              
        xorl    %eax, %eax                                 
        call    printf@PLT        // Вызов функции printf                        
        leaq    4(%rsp), %rsi                              
        leaq    .LC1(%rip), %rdi  // Определение параметра "%d" для printf                         
        xorl    %eax, %eax                                 
        call    __isoc99_scanf@PLT // Вызов функции scanf                        
.L9:                               // Начало цикла                        
        cmpl    %ebx, 4(%rsp)      // Если i становится равным n,                        
        jl      .L13                  то совершается переход к метке L13                      
        movl    %ebx, %edi                                 
        incl    %ebx                                       
        call    fib                // Вызов функции fib                        
        movq    %rbp, %rdi                                 
        movl    %eax, %esi                                 
        xorl    %eax, %eax                                 
        call    printf@PLT         // Вызов функции printf с подсчитанным ранее fib(i)                        
        jmp     .L9
.L13:                              // Выход из цикла                        
        movl    $10, %edi                                  
        call    putchar@PLT                                
        movq    8(%rsp), %rax                              
        subq    %fs:40, %rax                               
        je      .L11                                       
        call    __stack_chk_fail@PLT                       
.L11:                              // Конец функции main                        
        addq    $24, %rsp                                  
        .cfi_def_cfa_offset 24                             
        xorl    %eax, %eax                                 
        popq    %rbx                                       
        .cfi_def_cfa_offset 16                             
        popq    %rbp                                       
        .cfi_def_cfa_offset 8                              
        ret                                                
        .cfi_endproc                                       
.LFE1:                                                     
        .size   main, .-main                               
        .ident  "GCC: (GNU) 12.2.1 20230201"
 	.section        .note.GNU-stack,"",@progbits
