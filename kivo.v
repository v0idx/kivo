import readline

//Low-Level
fn editor_get_char_code(r readline.Readline) int {
	c := r.read_char()
	return c
}

fn editor_get_char(kp int) rune {
	return rune(kp)
}

//Input
fn process_key_press(mut r readline.Readline) {
	kp := editor_get_char_code(r)
	c := editor_get_char(kp)

	match kp {
		17 {r.disable_raw_mode()
		clear_screen()
		 	exit(0)}
		13 {print('\r\n')}
		else {print(c)}
	}
}

//Output
fn clear_screen() {
	print("\x1b[2J")
	print("\x1b[H")
}

fn set_screen() {
	clear_screen()

	draw_rows()
	print("\x1b[H")
}

fn draw_rows() {
	for i := 0; i < 24; i++ {
		print("~ \r\n")
	}
}

//Main
fn main() {
	mut rl := readline.Readline{}
	rl.enable_raw_mode()
	set_screen()
	for {
		process_key_press(mut rl)
	}
}