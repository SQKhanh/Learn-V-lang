module main

import net
import os

fn main() {
	println('Hello World!')

	port := 7979

	// Tạo socket lắng nghe kết nối TCP trên cổng 14445
	mut listener := net.listen_tcp(.ip, ':${port}') or {
		eprintln('Không thể lắng nghe trên cổng ${port}: ${err}')
		return
	}

	println('Server đang chạy trên cổng ${port}')

	for {
		// Chấp nhận một kết nối mới
		mut conn := listener.accept() or {
			eprintln('Lỗi khi chấp nhận kết nối: ${err}')
			continue
		}

		println('Kết nối mới từ ${conn.peer_addr()!}')

		// Xử lý kết nối trong một goroutine
		go handle_connection(mut conn)
	}
}

fn handle_connection(mut conn net.TcpConn) {
	defer {
		conn.close() or { eprintln('Lỗi khi chấp nhận kết nối: ${err}') }
	}

	mut buffer := []u8{len: 1024} // Bộ đệm để đọc dữ liệu từ client
	for {
		read_len := conn.read(mut buffer) or {
			eprintln('Lỗi khi đọc dữ liệu: ${err}')
			break
		}
		if read_len == 0 {
			println('Kết nối đóng bởi client')
			break
		}

		// Chuyển dữ liệu nhận được thành chuỗi
		message := buffer[..read_len].bytestr()
		println('Nhận từ client: ${message}')

		// Gửi lại thông điệp (echo) cho client
		conn.write_string('Server: ${message}') or {
			eprintln('Lỗi khi gửi dữ liệu: ${err}')
			break
		}
	}
}
