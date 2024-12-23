class FetchResponse {
    _value: any
  
    constructor(value: any) {
      this._value = value
    }
  
    /**
     * text
     */
    public text() {
      return String(this._value)
    }
  
    /**
     * name
     */
    public json() {
      return JSON.parse(this._value)
    }
  
    /**
     * blob
     */
    public blob() {
      let sliceSize = 1024;
      let byteCharacters = atob(this._value);
      let bytesLength = byteCharacters.length;
      let slicesCount = Math.ceil(bytesLength / sliceSize);
      let byteArrays = new Array(slicesCount);
  
      for (let sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
        let begin = sliceIndex * sliceSize;
        let end = Math.min(begin + sliceSize, bytesLength);
  
        let bytes = new Array(end - begin);
        for (let offset = begin, i = 0; offset < end; ++i, ++offset) {
          bytes[i] = (byteCharacters[offset] as string).charCodeAt(0);
        }
        byteArrays[sliceIndex] = new Uint8Array(bytes);
      }
      return new Blob(byteArrays);
    }
  }
  
  const V8Proxy = {
  
    fetch: (eventName: string, value: any = undefined) => {
  
      let v8uuid = String(Math.floor(Math.random() * 1000000))
      let v8type = 'undefined'
  
      switch (typeof (value)) {
        case 'string':
          v8type = 'string'
          break
        case 'boolean':
          v8type = 'bool'
          break
        case 'number':
          v8type = 'number'
          break
        case 'object':
          v8type = 'json'
          break
        case 'bigint':
          v8type = 'blob'
          break
      }
  
      return new Promise<FetchResponse>((resolve) => {
        console.debug(`V8Proxy.fetch(V8Proxy.fetch(${v8uuid}): ${eventName} ${v8type} ${String(value)}`)
  
        let res = document.getElementById('V8WebAppEventResponseForwarder') as HTMLButtonElement
        const handle = function () {
          if (res.getAttribute('v8uuid') === v8uuid) {
            res.removeEventListener('click', handle)
  
            console.debug(`V8Proxy.fetch(${v8uuid} resolve: ${res.value}`)
  
            resolve(new FetchResponse(res.value))
          }
        }
        res.addEventListener('click', handle)
  
        let req = document.getElementById('V8WebAppEventRequestForwarder') as HTMLButtonElement
        req.setAttribute('v8eventname', eventName)
        req.setAttribute('v8uuid', v8uuid)
        req.setAttribute('v8type', v8type)
        req.value = JSON.stringify(value)
        req.click();
      })
    },
    sendResponse: (v8uuid: string, value: string) => {
      let res = document.getElementById('V8WebAppEventResponseForwarder') as HTMLButtonElement
      res.setAttribute('v8uuid', v8uuid)
      res.value = value;
      res.click();
    }
  }
  
  export default V8Proxy