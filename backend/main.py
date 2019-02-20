from flask import Flask, jsonify

app = Flask(__name__, static_url_path='')


@app.route('/')
def root():
    return app.send_static_file('index.html')


@app.route('/api/shutdown', methods=['POST'])
def shutdown():
    import os
    import subprocess
    proc = subprocess.Popen(
        ['sudo', 'shutdown', '-h', '-t', '1'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        preexec_fn=os.setsid
    )  # with preexec_fn=os.setsid we disable that sudo can ask for a pw and hang forever
    (out, err) = proc.communicate()
    if proc.returncode == 0:
        status = 'success'
        info = out
    else:
        status = 'failed'
        info = err
    return jsonify({'status': status, 'info': info.decode('utf-8')})


if __name__ == '__main__':
    app.run(host='0.0.0.0')
