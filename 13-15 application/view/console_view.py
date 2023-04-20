def sent_msg(*args):
    result = ""
    for i in args:
        result += str(i)
    print(result)


def get_data(message=None):
    if message is None:
        return input()
    return input(message)
