#![no_std]
#![no_main]
#![feature(asm)]
#![feature(global_asm)]
#![feature(panic_info_message)]

use crate::sbi::shutdown;

#[macro_use]
mod console;
mod lang_items;
mod sbi;


global_asm!(include_str!("entry.asm"));

#[no_mangle]
extern "C" fn rust_main() {
    println!("hello world");
    shutdown();
}