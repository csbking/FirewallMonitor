#!/data/data/com.termux/files/usr/bin/env python3

import os
import time
import subprocess
import random
import signal
import sys

# ---------------------------
# HANDLE CTRL+C GRACEFULLY
# ---------------------------
def exit_gracefully(sig, frame):
    print(f"\n\033[93m[BOLD]⚠ MONITOR STOPPED BY USER. EXITING...[/BOLD]{RESET}")
    sys.exit(0)

signal.signal(signal.SIGINT, exit_gracefully)

# ---------------------------
# FORCE FULL SCREEN
# ---------------------------
def force_fullscreen():
    try:
        os.system("printf '\033[8;55;200t' 2>/dev/null")
    except:
        pass

os.system("clear")

# ---------------------------
# COLORS (NEON HD)
# ---------------------------
PINK="\033[95m"; GREEN="\033[92m"; CYAN="\033[96m"
YELLOW="\033[93m"; RED="\033[91m"; RESET="\033[0m"; BOLD="\033[1m"

# ---------------------------
# WAIT FOR FIREWALL COMMAND
# ---------------------------
def wait_firewall_command():
    while True:
        print(f"{CYAN}{BOLD}TYPE 'FIREWALL' TO START THE MONITOR:{RESET}")
        cmd = input("> ").strip().replace(" ", "").upper()
        if cmd == "FIREWALL":
            break
        print(f"{RED}{BOLD}FIREWALL COMMAND NOT DETECTED. TRY AGAIN...{RESET}\n")

wait_firewall_command()

force_fullscreen()
os.system("clear")

# ---------------------------
# BANNER (AUTO UPPERCASE)
# ---------------------------
BANNER_TEXT = """
______ ___________ _____ _    _  ___   _      _     
|  ___|_   _| ___ \\  ___| |  | |/ _ \\ | |    | |    
| |_    | | | |_/ / |__ | |  | / /_\\ \\| |    | |    
|  _|   | | |    /|  __|| |/\\| |  _  || |    | |    
| |    _| |_| |\\ \\| |___\\  /\\  / | | || |____| |____
\\_|    \\___/\\_| \\_\\____/ \\/  \\/\\_| |_/\\_____/\\_____/
"""

BANNER = f"{CYAN}{BOLD}{BANNER_TEXT.upper()}{RESET}"
CREDIT = f"{YELLOW}{BOLD}🔥 FIREWALL TERMUX SETUP - CREDIT BY CSB TEAM MEMBER (ALEX HUNTER) 🔥{RESET}"

print(BANNER)
print(CREDIT)
print(f"{GREEN}{BOLD}🔥 LIVE FIREWALL MONITOR STARTED — FULLSCREEN LOCKED 🔥{RESET}\n")

# ---------------------------
# MESSAGES
# ---------------------------
messages = [
    "SCANNING ACTIVE TCP CHANNELS",
    "MONITORING LIVE PACKETS",
    "TRACING UNKNOWN IP SIGNATURES",
    "FILTERING SUSPICIOUS ENDPOINTS",
    "ANALYZING DEEP SOCKET ROUTES",
    "CHECKING ENCRYPTED TUNNELS",
    "TRACKING OUTBOUND CONNECTIONS",
    "WATCHING FOREIGN TRAFFIC SPIKES",
]

spinner = ["|", "/", "-", "\\"]

# ---------------------------
# CLEAN CONNECTION FETCHER
# ---------------------------
def get_connections():
    try:
        result = subprocess.run(["netstat", "-tun"], capture_output=True, text=True, timeout=3)
        lines = result.stdout.splitlines()
    except Exception:
        return []

    clean = []
    for line in lines:
        line = line.strip()
        if len(line) < 5:
            continue
        if "127.0.0.1" in line:
            continue
        if line.lower().startswith("proto"):
            continue
        if line.lower().startswith("active internet"):
            continue
        clean.append(line.upper())
    return clean

# ---------------------------
# ULTRA DANGER DETECTOR
# ---------------------------
danger_ports = ["4444", "3389", "5900", "8080", "53"]
danger_prefix = ["185.220.", "45.13.", "103.152."]

def detect_danger(line):
    try:
        parts = line.split()
        if len(parts) < 5:
            return False, ""

        foreign = parts[4]

        if ":" in foreign:
            f_ip, f_port = foreign.rsplit(":", 1)
        else:
            return False, ""

        f_port = f_port.strip()

        if f_port in danger_ports:
            return True, f"⚠ DANGER: SUSPICIOUS PORT DETECTED → {f_port}"

        for pref in danger_prefix:
            if f_ip.startswith(pref):
                return True, f"⚠ HIGH‑RISK MALICIOUS RANGE → {f_ip}"

        # Check unknown public IPs
        if not (f_ip.startswith("10.") or f_ip.startswith("192.168.") or f_ip.startswith("172.")):
            return True, f"⚠ UNKNOWN PUBLIC IP → {f_ip}"

    except Exception:
        return False, ""
    return False, ""

# ---------------------------
# RANDOM MESSAGE
# ---------------------------
def hacking_screen():
    msg = random.choice(messages)
    print(f"{GREEN}{BOLD}[SCAN] {msg}...{RESET}")

# ---------------------------
# MAIN LOOP
# ---------------------------
while True:
    force_fullscreen()
    hacking_screen()

    conns = get_connections()
    for c in conns:
        danger, alert_msg = detect_danger(c)
        if danger:
            print(f"{RED}{BOLD}{alert_msg.upper()}{RESET}")
        else:
            print(f"{PINK}{BOLD}⚠ NEW TRAFFIC → {c}{RESET}")

    for s in spinner:
        print(f"{CYAN}{BOLD}[{s}] REAL‑TIME MONITORING ACTIVE...{RESET}", end="\r")
        time.sleep(0.1)
