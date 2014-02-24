part of rsd;

class RsdView implements Function {

  call(request, List args) {
    var method = getMethod(request).toLowerCase(),
        im = reflect(this),
        symbol = new Symbol(method);

    im.invoke(symbol, [request, args]);
  }

  String getMethod(request) => request.method;
}