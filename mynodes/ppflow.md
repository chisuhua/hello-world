


# PPU


每个cluster有三类worker, 有三个queue对应, queue内部就是命令包，和barrie包。
scheduler和CPU通信，并受


```
scheduler


DAG        cmd_queue    ---------------
          -----------   | cmp_worker  |
                        | ...         |
          -----------   | data_worker |  cluster0
                        | ...         |
          -----------   | ctrl_worker |
                        ---------------

                        ---------------
          -----------   | cmp_worker  |
                        | ...         |
          -----------   | data_worker |  cluster1
                        | ...         |
          -----------   | ctrl_worker |
                        ---------------

			...

```

- work steal 策略
    - scheduer把繁忙的queue， pop出task出来，然后放到empty的queue上
    - empty work去哪busy qeueu的task

用scheduler可以分析依赖关系，会创建必要的其他命令

# CPU  <--> PPU


CPU通过调用带stream_handle的函数，不断生成DAG, 并通过queue发给ppu
每个ppu对应一个dag_queue
每个cpu也有一样的的dag_queue. 同事根据cpu核心数有对应的worker和cmd_queue

queue内部是DAG的node_id，和barrier

```
CPU --stream    ---> DAG   ---> dag_queue   ---> ppu
                           ---> daq_queue   ---> ppu
                           ---> daq_queue   ---> ppu

			   ---> daq_queue   ---> cpu-schduler ---> cmd_queue   ----> work
			                                      ---> cmd_queue   ----> worker
			                                      ---> cmd_queue   ----> worker

```
