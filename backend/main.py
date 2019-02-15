from flask import Flask, jsonify

app = Flask(__name__, static_url_path='')


@app.route('/')
def root():
    return app.send_static_file('index.html')


@app.route('/api/shutdown', methods=['GET', 'POST'])
def shutdown():
    import os
    import subprocess
    proc = subprocess.Popen(
        ['sudo', 'shutdown', '-h', 'now'], stdout=subprocess.PIPE, preexec_fn=os.setsid
    )  # with preexec_fn=os.setsid we disable that sudo can ask for a pw and hang forever
    (out, err) = proc.communicate()
    if err == 0:
        return jsonify({'status': 'success'})
    else:
        return jsonify({'status': 'failed', 'reason': out.decode('utf-8')}), 500


if __name__ == '__main__':
    app.run(debug=True)
