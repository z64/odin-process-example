package process

import "core:fmt"

main :: proc() {
    p := process_start("cat main.odin")
    process_wait(p)

    output, ok := process_read_handle(p.output)
    assert(ok)

    fmt.print(string(output))
}
