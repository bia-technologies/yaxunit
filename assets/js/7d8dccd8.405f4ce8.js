"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[6196],{5788:(e,t,n)=>{n.d(t,{Iu:()=>c,yg:()=>g});var r=n(1504);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},i=Object.keys(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var p=r.createContext({}),u=function(e){var t=r.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},c=function(e){var t=u(e.components);return r.createElement(p.Provider,{value:t},e.children)},y="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},s=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,i=e.originalType,p=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),y=u(n),s=a,g=y["".concat(p,".").concat(s)]||y[s]||m[s]||i;return n?r.createElement(g,o(o({ref:t},c),{},{components:n})):r.createElement(g,o({ref:t},c))}));function g(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var i=n.length,o=new Array(i);o[0]=s;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l[y]="string"==typeof e?e:a,o[1]=l;for(var u=2;u<i;u++)o[u]=n[u];return r.createElement.apply(null,o)}return r.createElement.apply(null,n)}s.displayName="MDXCreateElement"},248:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>p,contentTitle:()=>o,default:()=>m,frontMatter:()=>i,metadata:()=>l,toc:()=>u});var r=n(5072),a=(n(1504),n(5788));const i={sidebar_position:9,title:"\u042e\u0422\u041e\u0431\u0449\u0438\u0439"},o="\u041e\u0431\u0449\u0438\u0439 (\u042e\u0422\u041e\u0431\u0449\u0438\u0439)",l={unversionedId:"\u042e\u0422\u041e\u0431\u0449\u0438\u0439",id:"\u042e\u0422\u041e\u0431\u0449\u0438\u0439",title:"\u042e\u0422\u041e\u0431\u0449\u0438\u0439",description:"\u041c\u0435\u0442\u043e\u0434\u044b \u043c\u043e\u0434\u0443\u043b\u044f",source:"@site/api/\u042e\u0422\u041e\u0431\u0449\u0438\u0439.md",sourceDirName:".",slug:"/\u042e\u0422\u041e\u0431\u0449\u0438\u0439",permalink:"/yaxunit/api/\u042e\u0422\u041e\u0431\u0449\u0438\u0439",draft:!1,tags:[],version:"current",sidebarPosition:9,frontMatter:{sidebar_position:9,title:"\u042e\u0422\u041e\u0431\u0449\u0438\u0439"},sidebar:"api",previous:{title:"\u042e\u0422\u041b\u043e\u0433\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435",permalink:"/yaxunit/api/\u042e\u0422\u041b\u043e\u0433\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435"},next:{title:"\u042e\u0422\u041f\u043e\u0434\u0440\u0430\u0436\u0430\u0442\u0435\u043b\u044c",permalink:"/yaxunit/api/\u042e\u0422\u041f\u043e\u0434\u0440\u0430\u0436\u0430\u0442\u0435\u043b\u044c"}},p={},u=[{value:"\u041c\u0435\u0442\u043e\u0434\u044b \u043c\u043e\u0434\u0443\u043b\u044f",id:"\u043c\u0435\u0442\u043e\u0434\u044b-\u043c\u043e\u0434\u0443\u043b\u044f",level:2},{value:"<code>\u0417\u043d\u0430\u0447\u0435\u043d\u0438\u0435\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430</code>",id:"\u0437\u043d\u0430\u0447\u0435\u043d\u0438\u0435\u0441\u0432\u043e\u0439\u0441\u0442\u0432\u0430",level:3}],c={toc:u},y="wrapper";function m(e){let{components:t,...n}=e;return(0,a.yg)(y,(0,r.c)({},c,n,{components:t,mdxType:"MDXLayout"}),(0,a.yg)("h1",{id:"\u043e\u0431\u0449\u0438\u0439-\u044e\u0442\u043e\u0431\u0449\u0438\u0439"},"\u041e\u0431\u0449\u0438\u0439 (\u042e\u0422\u041e\u0431\u0449\u0438\u0439)"),(0,a.yg)("h2",{id:"\u043c\u0435\u0442\u043e\u0434\u044b-\u043c\u043e\u0434\u0443\u043b\u044f"},"\u041c\u0435\u0442\u043e\u0434\u044b \u043c\u043e\u0434\u0443\u043b\u044f"),(0,a.yg)("hr",null),(0,a.yg)("h3",{id:"\u0437\u043d\u0430\u0447\u0435\u043d\u0438\u0435\u0441\u0432\u043e\u0439\u0441\u0442\u0432\u0430"},(0,a.yg)("inlineCode",{parentName:"h3"},"\u0417\u043d\u0430\u0447\u0435\u043d\u0438\u0435\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430")),(0,a.yg)("p",null,'\u0412\u043e\u0437\u0432\u0440\u0430\u0449\u0430\u0435\u0442 \u0437\u043d\u0430\u0447\u0435\u043d\u0438\u0435 \u0441\u0432\u043e\u0439\u0441\u0442\u0432\u0430 \u043e\u0431\u044a\u0435\u043a\u0442\u0430.\n\u0412\u043e\u0437\u043c\u043e\u0436\u043d\u043e \u043f\u043e\u043b\u0443\u0447\u0435\u043d\u0438\u0435 "\u0433\u043b\u0443\u0431\u043e\u043a\u043e" \u0432\u043b\u043e\u0436\u0435\u043d\u043d\u044b\u0445 \u0441\u0432\u043e\u0439\u0441\u0442\u0432\u043e \u0438 \u044d\u043b\u0435\u043c\u0435\u043d\u0442\u043e\u0432 \u043a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u0438 \u043f\u043e \u0438\u043d\u0434\u0435\u043a\u0441\u0443'),(0,a.yg)("p",null,(0,a.yg)("strong",{parentName:"p"},"\u041f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u044b \u043c\u0435\u0442\u043e\u0434\u0430")),(0,a.yg)("ul",null,(0,a.yg)("li",{parentName:"ul"},(0,a.yg)("inlineCode",{parentName:"li"},"\u041e\u0431\u044a\u0435\u043a\u0442"),(0,a.yg)("ul",{parentName:"li"},(0,a.yg)("li",{parentName:"ul"},(0,a.yg)("inlineCode",{parentName:"li"},"\u041f\u0440\u043e\u0438\u0437\u0432\u043e\u043b\u044c\u043d\u044b\u0439")," - "))),(0,a.yg)("li",{parentName:"ul"},(0,a.yg)("inlineCode",{parentName:"li"},"\u0418\u043c\u044f\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430"),(0,a.yg)("ul",{parentName:"li"},(0,a.yg)("li",{parentName:"ul"},(0,a.yg)("inlineCode",{parentName:"li"},"\u0421\u0442\u0440\u043e\u043a\u0430"),' - \u041f\u0443\u0442\u044c \u043a \u0441\u0432\u043e\u0439\u0441\u0442\u0432\u0443. \u041f\u0440\u0438\u043c\u0435\u0440\u044b: "\u0418\u043c\u044f\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430.\u0418\u043c\u044f\u0412\u043b\u043e\u0436\u0435\u043d\u043d\u043e\u0433\u043e\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430", "',"[2]",'.\u0418\u043c\u044f\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430", "\u0418\u043c\u044f\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430',"[2]",'.\u0418\u043c\u044f\u0412\u043b\u043e\u0436\u0435\u043d\u043d\u043e\u0433\u043e\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u0430"'),(0,a.yg)("li",{parentName:"ul"},(0,a.yg)("inlineCode",{parentName:"li"},"\u0427\u0438\u0441\u043b\u043e")," - \u0418\u043d\u0434\u0435\u043a\u0441 \u044d\u043b\u0435\u043c\u0435\u043d\u0442\u0430. \u0412\u043e\u0437\u043c\u043e\u0436\u0435\u043d \u0432\u044b\u0431\u043e\u0440 \u044d\u043b\u0435\u043c\u0435\u043d\u0442\u0430 \u0441 \u043a\u043e\u043d\u0446\u0430, \u0434\u043b\u044f \u044d\u0442\u043e\u0433\u043e \u043d\u0443\u0436\u043d\u043e \u0443\u043a\u0430\u0437\u044b\u0432\u0430\u0442\u044c \u043e\u0442\u0440\u0438\u0446\u0430\u0442\u0435\u043b\u044c\u043d\u044b\u0439 \u043d\u043e\u043c\u0435\u0440 \u044d\u043b\u0435\u043c\u0435\u043d\u0442\u0430 \u0441 \u043a\u043e\u043d\u0446\u0430,\n\u043d\u0430\u043f\u0440\u0438\u043c\u0435\u0440: '-1' - \u043f\u043e\u0441\u043b\u0435\u0434\u043d\u0438\u0439 \u044d\u043b\u0435\u043c\u0435\u043d\u0442, '-2' - \u043f\u0440\u0435\u0434\u043f\u043e\u0441\u043b\u0435\u0434\u043d\u0438\u0439")))),(0,a.yg)("p",null,(0,a.yg)("strong",{parentName:"p"},"\u0412\u043e\u0437\u0432\u0440\u0430\u0449\u0430\u0435\u0442")),(0,a.yg)("p",null,(0,a.yg)("inlineCode",{parentName:"p"},"\u041f\u0440\u043e\u0438\u0437\u0432\u043e\u043b\u044c\u043d\u044b\u0439")," -"))}m.isMDXComponent=!0}}]);