
1. 编程模型 : cuda 和线程池

c支持gem5的运行，及c++c线程池, 支持类型go的语言，及verilog仿真verilator

2. 系统以ppu组成: ppu分成warp和vector两种指令

系统有两种指令类型，一个是vector作为simt方式以warp为单位执行, 另一种是warp size=1的执行。
ppu(size = 1)
ppu(size = 32)

对应ppu(size=32) 作为cuda kernel
而ppu(size=1). 作为线程池。

也可以通过ppu(size=1)启动ppu(size=32) ThreadBlock

ppu(1) 和 ppu(32) 指令可以是兼容，ppu(1) 加了压缩。

ppu(32)物理核也可以执行ppu(1), 通过把ppu(1) vector部分发射的valu单元，作为指令buffer, 而warp部分都是在salu单元执行。

线程池的rtask可以和kernel互相配合，task做数据p搬移，kernel做下计算

3. ppu阵列.

线程池task可以在两个ppu之间搬运数据
kernel的每个block有一个对应的task做share memory的b共享搬运


4. 多warp共享寄存器

写共享:
在多warp通过共享的寄存器，多个warp的dot的结果可以合并在一起。

读共享:

5. global-to-shared non-conflict load

通过lds load指令，把global的数据写入shared, 提供灵活的stride，代替读入register, 再写入shared

ppu(32) 和 ppu(1) 异步通信

在L1/ShareMemory和L2之间有ppu(1)的执行核， ppu(1)可以作为DMA的engine, 根据ppu(32) 的请求，把pp(32)的sharememory进行搬运。
ppu(1) 和ppu(1) 之间通信通过fence, ppu(32) 可以通过barrier回到父亲ppu(1)的线程

6. 设计一个GDS/ShareMemory/Memory
ppu(1) 可以在Memory/ShareMemory/GDS之间做DMA, 可以做广播
并也可以做simd简单计算。
ppu(1) 的向量部分，是可以做simd指令，用vl(vector len)指示多少simd.
一个典型的应用是，ppu(1)可以处理ppu(32) 线程块的数据量，那么用vl通过编译器来处理
