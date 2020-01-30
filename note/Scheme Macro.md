macro的运行流程如下，可以看到和普通的procedure不同的地方在于第二步以及第三步。
1. Evaluate operator 
2. Apply operator to unevaluated operands 
3. Evaluate the expression returned by the macro in the frame it was called in

其中第二步相对好理解，就是operand不会先evaluate再绑定给argument。
第三步是关键，macro procedure运行body的代码，再去运行代码产生的输出（这个输出一般是个list）

