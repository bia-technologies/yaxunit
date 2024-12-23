import {
  WebsocketBuilder, ArrayQueue,
  ConstantBackoff, WebsocketEvent, Websocket
} from 'websocket-ts'
import V8Proxy from './V8Proxy'

let ws: Websocket;

function connect(endPoint: string) {
  ws = new WebsocketBuilder(endPoint)
    .withBuffer(new ArrayQueue())           // buffer messages when disconnected
    .withBackoff(new ConstantBackoff(1000)) // retry every 1s
    .onOpen(() => fire('open'))
    .onReconnect(() => fire('reconnect'))
    .onClose(() => fire('close'))
    .onError(() => fire('error'))
    .onMessage((_, ev) => fire('message', ev.data))
    .build();
  // Add event listeners
  ws.addEventListener(WebsocketEvent.open, () => fire("open"));
  ws.addEventListener(WebsocketEvent.close, () => console.log("closed!"));
  ws.addEventListener(WebsocketEvent.message, (...args) => console.log('message', ...args));
  ws.addEventListener(WebsocketEvent.error, (...args) => console.log('error', ...args));

  ws.send('pending')
}

function send (data: any){
  ws.send(data)
}
function fire(eventName: string, data?: any) {
  V8Proxy.fetch('socket.' + eventName, data)
}

(window as any).connect = connect;
(window as any).send = send;
