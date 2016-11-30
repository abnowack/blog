import ButteredPost.convert as bpost

if __name__ == '__main__':
    bpost.build('content', 'docs', info={'name': 'Aaron Nowack'})
    # bpost.serve('example/output')