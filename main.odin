package process

import "core:fmt"
import "core:os"


main :: proc() {
    p := process_start("cat -")

    s := "testing stdin\n"
    os.write(p.input, transmute([]byte)s)
    os.close(p.input)

    process_wait(p)

    output, ok := process_read_handle(p.output)
    assert(ok)

    fmt.print(string(output))
}
