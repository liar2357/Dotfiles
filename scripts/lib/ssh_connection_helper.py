import subprocess
import os

hosts = [
    ("DLRS-2606", {"tmux":True, "mosh":False}),
    ("RLDS-2610", {"tmux":True, "mosh":False}),
    ("FLDW-2509", {"tmux":True, "mosh":True}),
    ("WNDG-2011", {"tmux":False, "mosh":False}),
    ("WNVS-2604", {"tmux":False, "mosh":False}),
    ("FBVS-2606", {"tmux":False, "mosh":False}),
    ("DLVD-2610", {"tmux":True, "mosh":False}),
]


def exec_ssh_connection(hostname: str, isTermuxMode: bool):
    if isTermuxMode:
        subprocess.call(["ssh-wraper", hostname])

    else:
        subprocess.call(["ssh", hostname])


def exec_mosh_connection(hostname: str, isTermuxMode: bool):
    if isTermuxMode:
        subprocess.call(["mosh-wraper", hostname])

    else:
        subprocess.call(["mosh", hostname])

def exec_ssh_connection_no_tmux(hostname: str, isTermuxMode: bool):
    env = os.environ.copy()
    env["NO_TMUX"] = "1"

    if isTermuxMode:
        subprocess.call(["ssh-wraper", hostname], env=env)

    else:
        subprocess.call(["ssh", hostname], env=env)


def exec_mosh_connection_no_tmux(hostname: str, isTermuxMode: bool):
    env = os.environ.copy()
    env["NO_TMUX"] = "1"

    if isTermuxMode:
        subprocess.call(["mosh-wraper", hostname], env=env)

    else:
        subprocess.call(["mosh", hostname], env=env)

def ssh_connection_helper(isTermuxMode: bool):
    print("===SSH HOSTS===")

    for i, host in enumerate(hosts):
        print(f"{i+1}: {host[0]}")

    num: int

    while True:
        num_str: str = input("Select Host With Number: ")

        if num_str != "":
            try:
                num = int(num_str)

                if 1 <= num < len(hosts):
                    break
                else:
                    print(f"Avalable is 1~{len(hosts)-1}")
            except ValueError:
                print("Input Is Must Be Integer")
                continue

    if hosts[num - 1][1]["tmux"] or hosts[num - 1][1]["mosh"]:
        maxChoice: int

        print("=== OPTION ===")
        
        if hosts[num - 1][1]["tmux"] and hosts[num - 1][1]["mosh"]:
            maxChoice = 3
            print("0: enable tmux and mosh")
            print("1: enable tmux")
            print("2: enable mosh")
            print("3: vanila ssh")
        elif hosts[num - 1][1]["tmux"] and not hosts[num - 1][1]["mosh"]:
            maxChoice = 1
            print("0: enable tmux")
            print("1: vanila ssh")
        elif not hosts[num - 1][1]["tmux"] and hosts[num - 1][1]["mosh"]:
            maxChoice = 1
            print("0: enable mosh")
            print("1: vanila ssh")

        option = input("Select number. (default=0) : ")

        if option == "":
            option = "0"

        optionNum: int

        try:
            optionNum = int(option)

            if optionNum < 0 or optionNum > maxChoice:
                print("fallback to default becuse invalid select")
                optionNum = 0

        except ValueError:
            print("fallback to default becuse invalid select")
            optionNum = 0


        if hosts[num - 1][1]["tmux"] and hosts[num - 1][1]["mosh"]:
            if optionNum == 0:
                exec_mosh_connection(hosts[num - 1][0], isTermuxMode)
            elif optionNum == 1:
                exec_ssh_connection(hosts[num - 1][0], isTermuxMode)
            elif optionNum == 2:
                exec_mosh_connection_no_tmux(hosts[num - 1][0], isTermuxMode)
            elif optionNum == 3:
                exec_ssh_connection_no_tmux(hosts[num - 1][0], isTermuxMode)

        elif hosts[num - 1][1]["tmux"] and not hosts[num - 1][1]["mosh"]:
            if optionNum == 0:
                exec_ssh_connection(hosts[num - 1][0], isTermuxMode)
            elif optionNum == 1:
                exec_ssh_connection_no_tmux(hosts[num - 1][0], isTermuxMode)

        elif not hosts[num - 1][1]["tmux"] and hosts[num - 1][1]["mosh"]:
            if optionNum == 0:
                exec_mosh_connection(hosts[num - 1][0], isTermuxMode)
            elif optionNum == 1:
                exec_ssh_connection(hosts[num - 1][0], isTermuxMode)

    else:
        exec_ssh_connection(hosts[num - 1][0], isTermuxMode)
