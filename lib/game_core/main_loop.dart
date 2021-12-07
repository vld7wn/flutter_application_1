import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async{
  double _fps = 60;
  double _second = 1000;
  double _updateTime = _second/_fps;
  double _updates = 0;

  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();
  Stopwatch _timeWatch = Stopwatch();
  _timeWatch.start();
  while(_running) {
    if(_loopWatch.elapsedMilliseconds >= _updateTime) {
      _updates++;
      _loopWatch.reset();
      sendPort.send(true);
    }

    if(_timeWatch.elapsedMilliseconds > _second){
      //("${DateTime.now()} FPS: $_updates");
      _updates = 0;
      _timeWatch.reset();
    }
  }
}

void stopLoop() {
  _running = false;
}