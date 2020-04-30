use rouille::Response;
use std::env;
use chrono::prelude::*;
use std::{process};
extern crate ctrlc;

fn main() {
    let port = env::var("PORT").unwrap_or("8080".to_string());
    let address = format!("0.0.0.0:{}", port);
    
    ctrlc::set_handler(move || {
        println!("[{:?}] Received SIGTERM", Local::now());
        println!("[{:?}] Stopping server", Local::now());
        process::exit(0);
    })
    .expect("Error setting Ctrl-C handler");

    println!("[{:?}] Starting server on {}", Local::now(), address);
    rouille::start_server(address, move |request| {
        println!("[{:?}] Received request on {}", Local::now(), request.url());
        let message = env::var("MESSAGE").unwrap_or("Hello My World".to_string());
        Response::text(message)
    });
}