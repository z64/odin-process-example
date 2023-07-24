package process

import "core:fmt"
import "core:os"

run_command :: proc(cmd: string, input: Maybe(string)) -> string {
    p := process_start(cmd)

    if input, ok := input.?; ok {
        os.write(p.input, transmute([]byte)input)
    }
    os.close(p.input)

    process_wait(p)

    output, ok := process_read_handle(p.output)
    assert(ok)

    return string(output)
}


main :: proc() {
    output_ps := run_command("ps aux", nil)
    fmt.println("$ ps aux = ", output_ps)

    output_grep := run_command("grep odin", output_ps)
    fmt.println("$ grep odin = ", output_grep)

    output_wc := run_command("wc -l", output_ps)
    fmt.println("$ wc -l = ", output_wc)
}
