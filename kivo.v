import readline
import term

//Data
struct EditorConfig {
	mut :
		term_width int
		term_height int
		cursor_pos term.Coord
}


//Low-Level

fn init_editor(mut e EditorConfig) {
	mut width, height := term.get_terminal_size()
	e.cursor_pos.x = 0
	e.cursor_pos.y = 0
	e.term_width = width
	e.term_height = height
}

fn editor_get_char_code(r readline.Readline) int {
	c := r.read_char()
	return c
}

fn editor_get_char(kp int) rune {
	return rune(kp)
}

//Input
fn process_key_press(mut r readline.Readline, mut e EditorConfig) {
	kp := editor_get_char_code(r)
	c := editor_get_char(kp)


	match kp {
		17 {r.disable_raw_mode()
		clear_screen()
		 	exit(0)}
		13 {print('\r\n')}
		119, 97, 115, 100 {editor_move_cursor(kp, mut e)}
		else {print(c)}
	}
}

fn editor_move_cursor(key int, mut e EditorConfig) {
	match key {
		119 {e.cursor_pos.y --}
		97 {e.cursor_pos.x --}
		115 {e.cursor_pos.y ++}
		100 {e.cursor_pos.x ++}
		else {}
	}
}

//Output
fn clear_screen() {
	term.clear()
}

fn draw_rows(h int) {
	for i := 0; i < h; i++ {
		print("~")

		term.erase_line_toend()
		if i < h - 1 {
			print("\r\n")
		}
	}
}

fn refresh_cursor(e EditorConfig) {
	term.set_cursor_position(e.cursor_pos)
}

fn set_screen(e EditorConfig) {
	term.hide_cursor()
	height := e.term_height
	draw_rows(height)
	term.set_cursor_position(e.cursor_pos)
	term.show_cursor()
}

//Main
fn main() {
	mut rl := readline.Readline{}
	mut ed_config := EditorConfig {}
	init_editor(mut ed_config)
	rl.enable_raw_mode()
	set_screen(ed_config)
	for {
		refresh_cursor(ed_config)
		process_key_press(mut rl, mut ed_config)
	}
}