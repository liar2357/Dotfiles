import subprocess

hosts = [
    ("DRS-2606", False),
    ("FDW-2509", True),
    ("WDG-2011", False),
    ("WVS-2604", False),
    ("FVS-2606", False),
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

    if hosts[num - 1][1]:
        yn = input("You Can Use Mosh for SSH Connection. (Y/n) : ")
        if yn == "n" or yn == "N":
            exec_ssh_connection(hosts[num - 1][0], isTermuxMode)
        else:
            exec_mosh_connection(hosts[num - 1][0], isTermuxMode)
    else:
        exec_ssh_connection(hosts[num - 1][0], isTermuxMode)
