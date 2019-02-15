# RPI-Remote
A small webapp to control a raspberry pi.

## Installation
We need supervisor and pipenv on the raspberry pi. 

```
scripts/setup_pi_dependencies.sh
scripts/deploy.sh
```

## Development

### Frontend
```
cd frontend && ./node.sh /bin/bash -c "npm install && ./node_modules/gulp/bin/gulp.js"
firefox http://localhost:3000/
```
### Backend
```
cd backend
pipenv install && pipenv run python ./main.py
```
