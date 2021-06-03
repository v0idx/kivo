import readline

fn main() {
	mut rl := readline.Readline{}
	rl.enable_raw_mode()
	mut c := 0
	for {
		c = rl.read_char()
		if c == 17 {
			break
		}
		print('${rune(c)}')
		if c == 13 {
			println("")
		}
	}
	rl.disable_raw_mode()
}