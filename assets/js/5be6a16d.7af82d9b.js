"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[4826],{3905:(e,n,t)=>{t.d(n,{Zo:()=>c,kt:()=>k});var a=t(7294);function r(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function l(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function p(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?l(Object(t),!0).forEach((function(n){r(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):l(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function i(e,n){if(null==e)return{};var t,a,r=function(e,n){if(null==e)return{};var t,a,r={},l=Object.keys(e);for(a=0;a<l.length;a++)t=l[a],n.indexOf(t)>=0||(r[t]=e[t]);return r}(e,n);if(Object.getOwnPropertySymbols){var l=Object.getOwnPropertySymbols(e);for(a=0;a<l.length;a++)t=l[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(r[t]=e[t])}return r}var o=a.createContext({}),u=function(e){var n=a.useContext(o),t=n;return e&&(t="function"==typeof e?e(n):p(p({},n),e)),t},c=function(e){var n=u(e.components);return a.createElement(o.Provider,{value:n},e.children)},s="mdxType",m={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},d=a.forwardRef((function(e,n){var t=e.components,r=e.mdxType,l=e.originalType,o=e.parentName,c=i(e,["components","mdxType","originalType","parentName"]),s=u(t),d=r,k=s["".concat(o,".").concat(d)]||s[d]||m[d]||l;return t?a.createElement(k,p(p({ref:n},c),{},{components:t})):a.createElement(k,p({ref:n},c))}));function k(e,n){var t=arguments,r=n&&n.mdxType;if("string"==typeof e||r){var l=t.length,p=new Array(l);p[0]=d;var i={};for(var o in n)hasOwnProperty.call(n,o)&&(i[o]=n[o]);i.originalType=e,i[s]="string"==typeof e?e:r,p[1]=i;for(var u=2;u<l;u++)p[u]=t[u];return a.createElement.apply(null,p)}return a.createElement.apply(null,t)}d.displayName="MDXCreateElement"},6178:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>o,contentTitle:()=>p,default:()=>m,frontMatter:()=>l,metadata:()=>i,toc:()=>u});var a=t(7462),r=(t(7294),t(3905));const l={tags:["\u041d\u0430\u0447\u0430\u043b\u043e","\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b","\u0423\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f","\u0417\u0430\u043f\u0440\u043e\u0441\u044b","\u041c\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435"]},p="\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b",i={unversionedId:"user-api/predicates",id:"user-api/predicates",title:"\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b",description:"\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b \u044d\u0442\u043e \u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f, \u043a\u043e\u0442\u043e\u0440\u044b\u0435 \u0432\u044b \u043c\u043e\u0436\u0435\u0442\u0435 \u043f\u0435\u0440\u0435\u0434\u0430\u0432\u0430\u0442\u044c \u0432 \u043a\u0430\u0447\u0435\u0441\u0442\u0432\u0435 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432.",source:"@site/docs/user-api/predicates.md",sourceDirName:"user-api",slug:"/user-api/predicates",permalink:"/yaxunit/docs/user-api/predicates",draft:!1,editUrl:"https://github.com/bia-technologies/yaxunit/docs/user-api/predicates.md",tags:[{label:"\u041d\u0430\u0447\u0430\u043b\u043e",permalink:"/yaxunit/docs/tags/\u043d\u0430\u0447\u0430\u043b\u043e"},{label:"\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b",permalink:"/yaxunit/docs/tags/\u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b"},{label:"\u0423\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f",permalink:"/yaxunit/docs/tags/\u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f"},{label:"\u0417\u0430\u043f\u0440\u043e\u0441\u044b",permalink:"/yaxunit/docs/tags/\u0437\u0430\u043f\u0440\u043e\u0441\u044b"},{label:"\u041c\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435",permalink:"/yaxunit/docs/tags/\u043c\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435"}],version:"current",frontMatter:{tags:["\u041d\u0430\u0447\u0430\u043b\u043e","\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b","\u0423\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f","\u0417\u0430\u043f\u0440\u043e\u0441\u044b","\u041c\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435"]},sidebar:"tutorialSidebar",previous:{title:"\u041c\u043e\u043a\u0438\u0442\u043e",permalink:"/yaxunit/docs/user-api/mockito"},next:{title:"\u0417\u0430\u043f\u0440\u043e\u0441\u044b",permalink:"/yaxunit/docs/user-api/queries"}},o={},u=[{value:"\u041f\u0440\u0438\u043c\u0435\u0440\u044b \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u044f",id:"\u043f\u0440\u0438\u043c\u0435\u0440\u044b-\u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u044f",level:2},{value:"\u041e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438",id:"\u043e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438",level:2},{value:"\u041e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438 \u043a\u043e\u043d\u0442\u0435\u043a\u0441\u0442\u0430",id:"\u043e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438-\u043a\u043e\u043d\u0442\u0435\u043a\u0441\u0442\u0430",level:3},{value:"\u041e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438 \u0440\u0435\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0438",id:"\u043e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438-\u0440\u0435\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0438",level:3}],c={toc:u},s="wrapper";function m(e){let{components:n,...t}=e;return(0,r.kt)(s,(0,a.Z)({},c,t,{components:n,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"\u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b"},"\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b"),(0,r.kt)("p",null,"\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b \u044d\u0442\u043e \u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f, \u043a\u043e\u0442\u043e\u0440\u044b\u0435 \u0432\u044b \u043c\u043e\u0436\u0435\u0442\u0435 \u043f\u0435\u0440\u0435\u0434\u0430\u0432\u0430\u0442\u044c \u0432 \u043a\u0430\u0447\u0435\u0441\u0442\u0432\u0435 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432.\n\u041e\u043d\u0438 \u0440\u0430\u0441\u0448\u0438\u0440\u044f\u044e\u0442 \u0438 \u0443\u043d\u0438\u0444\u0438\u0446\u0438\u0440\u0443\u044e\u0442 \u0444\u0443\u043d\u043a\u0446\u0438\u043e\u043d\u0430\u043b\u044c\u043d\u043e\u0441\u0442\u044c \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u0434\u0432\u0438\u0436\u043a\u0430."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u041f\u0440\u043e\u0446\u0435\u0434\u0443\u0440\u0430 \u0410\u043a\u0442\u0443\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u044f\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u0439() \u042d\u043a\u0441\u043f\u043e\u0440\u0442\n    \n    \u0418\u043c\u044f\u0420\u0435\u0433\u0438\u0441\u0442\u0440\u0430 = "\u0420\u0435\u0433\u0438\u0441\u0442\u0440\u0421\u0432\u0435\u0434\u0435\u043d\u0438\u0439.\u041e\u043f\u043e\u0432\u0435\u0449\u0435\u043d\u0438\u044f\u041f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044f";\n    \u041e\u0431\u044a\u0435\u043a\u0442 = \u0422\u0435\u0441\u0442\u043e\u0432\u044b\u0435\u0414\u0430\u043d\u043d\u044b\u0435.\u041e\u0431\u044a\u0435\u043a\u0442();\n    \n    \u0423\u0441\u043b\u043e\u0432\u0438\u0435\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f = \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u0418\u0441\u0442\u043e\u0447\u043d\u0438\u043a").\u0420\u0430\u0432\u043d\u043e(\u041e\u0431\u044a\u0435\u043a\u0442)\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u0422\u0438\u043f\u041e\u043f\u043e\u0432\u0435\u0449\u0435\u043d\u0438\u044f").\u0420\u0430\u0432\u043d\u043e(\u0421\u043f\u0440\u0430\u0432\u043e\u0447\u043d\u0438\u043a\u0438.\u0422\u0438\u043f\u044b\u041e\u043f\u043e\u0432\u0435\u0449\u0435\u043d\u0438\u0439\u041f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044f.\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u04351)\n        .\u041f\u043e\u043b\u0443\u0447\u0438\u0442\u044c();\n    \n    \u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e\u0422\u0430\u0431\u043b\u0438\u0446\u0430\u0411\u0430\u0437\u044b(\u0418\u043c\u044f\u0420\u0435\u0433\u0438\u0441\u0442\u0440\u0430)\n        .\u041d\u0435\u0421\u043e\u0434\u0435\u0440\u0436\u0438\u0442\u0417\u0430\u043f\u0438\u0441\u0438(\u0423\u0441\u043b\u043e\u0432\u0438\u0435\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f);\n    \n    \u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f\u0412\u044b\u0437\u043e\u0432\u0421\u0435\u0440\u0432\u0435\u0440\u0430.\u0410\u043a\u0442\u0443\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u044f\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u0439();\n    \n    \u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e\u0422\u0430\u0431\u043b\u0438\u0446\u0430\u0411\u0430\u0437\u044b(\u0418\u043c\u044f\u0420\u0435\u0433\u0438\u0441\u0442\u0440\u0430)\n        .\u0421\u043e\u0434\u0435\u0440\u0436\u0438\u0442\u0417\u0430\u043f\u0438\u0441\u0438(\u0423\u0441\u043b\u043e\u0432\u0438\u0435\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f);\n    \n    \u0414\u0430\u043d\u043d\u044b\u0435\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f = \u042e\u0422\u0417\u0430\u043f\u0440\u043e\u0441\u044b.\u0417\u0430\u043f\u0438\u0441\u044c(\u0418\u043c\u044f\u0420\u0435\u0433\u0438\u0441\u0442\u0440\u0430, \u0423\u0441\u043b\u043e\u0432\u0438\u0435\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f);\n    \n    \u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e(\u0414\u0430\u043d\u043d\u044b\u0435\u0423\u0432\u0435\u0434\u043e\u043c\u043b\u0435\u043d\u0438\u044f)\n        .\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u043e("\u041f\u0440\u043e\u0447\u0438\u0442\u0430\u043d\u043e").\u042d\u0442\u043e\u041b\u043e\u0436\u044c()\n        .\u0421\u0432\u043e\u0439\u0441\u0442\u0432\u043e("\u041f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044c").\u0420\u0430\u0432\u043d\u043e(\u0421\u043f\u0440\u0430\u0432\u043e\u0447\u043d\u0438\u043a\u0438.\u0413\u0440\u0443\u043f\u043f\u044b\u041e\u043f\u043e\u0432\u0435\u0449\u0435\u043d\u0438\u0439\u041f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u0435\u0439.\u0418\u043d\u0436\u0435\u043d\u0435\u0440);\n    \n\u041a\u043e\u043d\u0435\u0446\u041f\u0440\u043e\u0446\u0435\u0434\u0443\u0440\u044b\n')),(0,r.kt)("p",null,"\u041c\u0435\u0445\u0430\u043d\u0438\u0437\u043c \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u043e\u0432:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"\u043f\u043e\u0437\u0432\u043e\u043b\u044f\u0435\u0442 \u0444\u043e\u0440\u043c\u0438\u0440\u043e\u0432\u0430\u0442\u044c \u043d\u0430\u0431\u043e\u0440\u044b \u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u0439 \u0438 \u043f\u0435\u0440\u0435\u0434\u0430\u0432\u0430\u0442\u044c \u0438\u0445 \u0432 \u043a\u0430\u0447\u0435\u0441\u0442\u0432\u0430 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432;"),(0,r.kt)("li",{parentName:"ul"},"\u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0435\u0442\u0441\u044f \u0434\u043b\u044f \u043f\u0440\u043e\u0432\u0435\u0440\u043a\u0438 \u043a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u0439, \u0437\u0430\u043f\u0438\u0441\u0435\u0439 \u0431\u0430\u0437\u044b \u0438 \u0442\u0430\u043a \u0434\u0430\u043b\u0435\u0435;"),(0,r.kt)("li",{parentName:"ul"},"\u043f\u043e\u0441\u0442\u0440\u043e\u0435\u043d \u043f\u043e \u043c\u043e\u0434\u0435\u043b\u0438 \u0442\u0435\u043a\u0443\u0447\u0438\u0445 \u0432\u044b\u0440\u0430\u0436\u0435\u043d\u0438\u044f \u0438 \u0438\u043c\u0435\u0435\u0442 \u0441\u0445\u043e\u0436\u0438\u0439 \u0441 \u0431\u0430\u0437\u043e\u0432\u044b\u043c\u0438 \u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f\u043c\u0438 \u0441\u0438\u043d\u0442\u0430\u043a\u0441\u0438\u0441 (",(0,r.kt)("inlineCode",{parentName:"li"},"\u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e()"),");")),(0,r.kt)("h2",{id:"\u043f\u0440\u0438\u043c\u0435\u0440\u044b-\u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u044f"},"\u041f\u0440\u0438\u043c\u0435\u0440\u044b \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u044f"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430 \u043a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u0438"),(0,r.kt)("pre",{parentName:"li"},(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e(\u041a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u044f)\n    .\u041b\u044e\u0431\u043e\u0439\u042d\u043b\u0435\u043c\u0435\u043d\u0442\u0421\u043e\u043e\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0443\u0435\u0442\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u0443(\u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u0427\u0438\u0441\u043b\u043e").\u0420\u0430\u0432\u043d\u043e(2)); // \u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0442, \u0447\u0442\u043e \u0432 \u043a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u0438 \u0435\u0441\u0442\u044c \u044d\u043b\u0435\u043c\u0435\u043d\u0442\u044b \u0441 \u0440\u0435\u043a\u0432\u0438\u0437\u0438\u0442\u043e\u043c `\u0427\u0438\u0441\u043b\u043e`, \u043a\u043e\u0442\u043e\u0440\u043e\u0435 \u0440\u0430\u0432\u043d\u043e `2`\n\n\u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e(\u041a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u044f)\n    .\u041a\u0430\u0436\u0434\u044b\u0439\u042d\u043b\u0435\u043c\u0435\u043d\u0442\u0421\u043e\u043e\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0443\u0435\u0442\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u0443(\u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n        .\u0417\u0430\u043f\u043e\u043b\u043d\u0435\u043d\u043e().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u041c\u0430\u0441\u0441\u0438\u0432")); // \u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0442, \u0447\u0442\u043e \u043a\u0430\u0436\u0434\u044b\u0439 \u044d\u043b\u0435\u043c\u0435\u043d\u0442 \u043a\u043e\u043b\u043b\u0435\u043a\u0446\u0438\u0438 \u044d\u0442\u043e \u0437\u0430\u043f\u043e\u043b\u043d\u0435\u043d\u043d\u044b\u0439 \u043c\u0430\u0441\u0441\u0438\u0432\n'))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"\u041e\u043f\u0438\u0441\u0430\u043d\u0438\u044f \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432 \u043c\u0435\u0442\u043e\u0434\u0430 \u043f\u0440\u0438 \u043c\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0438"),(0,r.kt)("p",{parentName:"li"},"  \u041d\u0430\u043f\u0440\u0438\u043c\u0435\u0440, \u0438\u043c\u0435\u0435\u043c \u043c\u0435\u0442\u043e\u0434, \u043a\u043e\u0442\u043e\u0440\u044b\u0439 \u043f\u0440\u0438\u043d\u0438\u043c\u0430\u0435\u0442 \u0432 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u0430\u0445 \u0441\u0442\u0440\u0443\u043a\u0442\u0443\u0440\u0443. \u041d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e \u0432\u0435\u0440\u043d\u0443\u0442\u044c 2 \u0440\u0430\u0437\u043d\u044b\u0445 \u0440\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442\u0430 \u0432 \u0437\u0430\u0432\u0438\u0441\u0438\u043c\u043e\u0441\u0442\u0438 \u043e\u0442 \u0437\u043d\u0430\u0447\u0435\u043d\u0438\u044f \u0440\u0435\u043a\u0432\u0438\u0437\u0438\u0442\u0430 \u0432\u0445\u043e\u0434\u043d\u043e\u0439 \u0441\u0442\u0440\u0443\u043a\u0442\u0443\u0440\u044b."),(0,r.kt)("pre",{parentName:"li"},(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u041c\u043e\u043a\u0438\u0442\u043e.\u041e\u0431\u0443\u0447\u0435\u043d\u0438\u0435(\u041c\u043e\u0434\u0443\u043b\u044c)\n    .\u041a\u043e\u0433\u0434\u0430(\u041c\u043e\u0434\u0443\u043b\u044c.\u041f\u043e\u0441\u0447\u0438\u0442\u0430\u0442\u044c(\u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n            .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u041e\u043f\u0435\u0440\u0430\u0442\u043e\u0440").\u0420\u0430\u0432\u043d\u043e("\u0421\u043b\u043e\u0436\u0438\u0442\u044c")))\n    .\u0412\u0435\u0440\u043d\u0443\u0442\u044c\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442(\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u04421)\n\n    .\u041a\u043e\u0433\u0434\u0430(\u041c\u043e\u0434\u0443\u043b\u044c.\u041f\u043e\u0441\u0447\u0438\u0442\u0430\u0442\u044c(\u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n            .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u041e\u043f\u0435\u0440\u0430\u0442\u043e\u0440").\u0420\u0430\u0432\u043d\u043e("\u0412\u044b\u0447\u0435\u0441\u0442\u044c")))\n    .\u0412\u0435\u0440\u043d\u0443\u0442\u044c\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442(\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u04422);\n'))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"\u0423\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f, \u043f\u0440\u043e\u0432\u0435\u0440\u044f\u044e\u0449\u0438\u0435 \u0434\u0430\u043d\u043d\u044b\u0435 \u0432 \u0431\u0430\u0437\u0435 \u043d\u0430 \u043e\u0441\u043d\u043e\u0432\u0430\u043d\u0438\u0438 \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u043e\u0432."),(0,r.kt)("pre",{parentName:"li"},(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u042e\u0422\u0435\u0441\u0442.\u041e\u0436\u0438\u0434\u0430\u0435\u0442\u0427\u0442\u043e\u0422\u0430\u0431\u043b\u0438\u0446\u0430("\u0421\u043f\u0440\u0430\u0432\u043e\u0447\u043d\u0438\u043a.\u0422\u043e\u0432\u0430\u0440\u044b").\u0421\u043e\u0434\u0435\u0440\u0436\u0438\u0442\u0417\u0430\u043f\u0438\u0441\u0438(\n    \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u041d\u0430\u0438\u043c\u0435\u043d\u043e\u0432\u0430\u043d\u0438\u0435").\u0420\u0430\u0432\u043d\u043e("\u0422\u043e\u0432\u0430\u0440 1")\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u0421\u0441\u044b\u043b\u043a\u0430").\u041d\u0435\u0420\u0430\u0432\u043d\u043e(\u0418\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0435)\n);\n'))),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("p",{parentName:"li"},"\u041f\u043e\u043b\u0443\u0447\u0435\u043d\u0438\u0435 \u0437\u0430\u043f\u0438\u0441\u0435\u0439 \u0438\u0437 \u0431\u0430\u0437\u044b"),(0,r.kt)("pre",{parentName:"li"},(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u0414\u0430\u043d\u043d\u044b\u0435\u0422\u043e\u0432\u0430\u0440\u0430 = \u042e\u0422\u0417\u0430\u043f\u0440\u043e\u0441\u044b.\u0417\u0430\u043f\u0438\u0441\u044c("\u0421\u043f\u0440\u0430\u0432\u043e\u0447\u043d\u0438\u043a.\u0422\u043e\u0432\u0430\u0440\u044b", \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442()\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u041d\u0430\u0438\u043c\u0435\u043d\u043e\u0432\u0430\u043d\u0438\u0435").\u0420\u0430\u0432\u043d\u043e("\u0422\u043e\u0432\u0430\u0440 1")\n        .\u0420\u0435\u043a\u0432\u0438\u0437\u0438\u0442("\u0421\u0441\u044b\u043b\u043a\u0430").\u041d\u0435\u0420\u0430\u0432\u043d\u043e(\u0418\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0435));\n')))),(0,r.kt)("h2",{id:"\u043e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438"},"\u041e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438"),(0,r.kt)("h3",{id:"\u043e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438-\u043a\u043e\u043d\u0442\u0435\u043a\u0441\u0442\u0430"},"\u041e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438 \u043a\u043e\u043d\u0442\u0435\u043a\u0441\u0442\u0430"),(0,r.kt)("p",null,"\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b \u043a\u0430\u043a \u0438 \u0431\u043e\u043b\u044c\u0448\u0438\u043d\u0441\u0442\u0432\u043e \u043c\u0435\u0445\u0430\u043d\u0438\u0437\u043c\u043e\u0432 \u043f\u043e\u0441\u0442\u0440\u043e\u0435\u043d\u044b \u043d\u0430 \u0442\u0435\u043a\u0443\u0447\u0438\u0445 \u0432\u044b\u0440\u0430\u0436\u0435\u043d\u0438\u044f\u0445 \u0441 \u0441\u043e\u0445\u0440\u0430\u043d\u0435\u043d\u0438\u0435\u043c \u0441\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u044f \u0432 \u0433\u043b\u043e\u0431\u0430\u043b\u044c\u043d\u043e\u043c \u043a\u043e\u043d\u0442\u0435\u043a\u0441\u0442\u0435."),(0,r.kt)("p",null,"\u042d\u0442\u043e \u043f\u0440\u0438\u0432\u043e\u0434\u0438\u0442 \u043a \u0442\u043e\u043c\u0443, \u0447\u0442\u043e \u0432\u044b \u043d\u0435 \u043c\u043e\u0436\u0435\u0442\u0435 \u0441\u0440\u0430\u0437\u0443 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c \u043d\u0435\u0441\u043a\u043e\u043b\u044c\u043a\u043e \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u043e\u0432, \u043d\u0430\u043f\u0440\u0438\u043c\u0435\u0440"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u041c\u043e\u043a\u0438\u0442\u043e.\u041e\u0431\u0443\u0447\u0435\u043d\u0438\u0435(\u041c\u043e\u0434\u0443\u043b\u044c)\n    .\u041a\u043e\u0433\u0434\u0430(\u041c\u043e\u0434\u0443\u043b\u044c.\u0421\u0434\u0435\u043b\u0430\u0442\u044c\u0427\u0442\u043e\u0422\u043e(\n        \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0421\u0442\u0440\u043e\u043a\u0430"),\n        \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0427\u0438\u0441\u043b\u043e")))\n    .\u0412\u0435\u0440\u043d\u0443\u0442\u044c\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442(\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u04421);\n')),(0,r.kt)("p",null,"\u0412 \u044d\u0442\u043e\u043c \u043f\u0440\u0438\u043c\u0435\u0440\u0435 1\u0421 \u0441\u043d\u0430\u0447\u0430\u043b\u0430 \u0432\u044b\u0447\u0438\u0441\u043b\u0438\u0442 \u0432\u044b\u0440\u0430\u0436\u0435\u043d\u0438\u044f \u0434\u043b\u044f \u0432\u0441\u0435\u0445 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432, \u0430 \u043f\u043e\u0442\u043e\u043c \u043f\u0435\u0440\u0435\u0434\u0430\u0441\u0442 \u0438\u0445 \u0432 \u043c\u0435\u0442\u043e\u0434 \u0438 \u043c\u044b \u043f\u043e\u043b\u0443\u0447\u0438\u043c \u0434\u043b\u044f \u043e\u0431\u043e\u0438\u0445 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432 \u043e\u0434\u0438\u043d \u0438 \u0442\u043e\u0442 \u0436\u0435 \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442, \u043e\u0436\u0438\u0434\u0430\u044e\u0449\u0438\u0439 \u0442\u0438\u043f ",(0,r.kt)("inlineCode",{parentName:"p"},"\u0427\u0438\u0441\u043b\u043e"),".\n\u041f\u043e\u0442\u043e\u043c\u0443 \u0447\u0442\u043e \u0441\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u0435 \u043f\u0435\u0440\u0432\u043e\u0433\u043e \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u0430 \u0431\u0443\u0434\u0435\u0442 \u0437\u0430\u043c\u0435\u043d\u0435\u043d\u043e \u0432\u0442\u043e\u0440\u044b\u043c. \u0414\u043b\u044f \u043e\u0431\u0445\u043e\u0434\u0430 \u044d\u0442\u043e\u0439 \u043f\u0440\u043e\u0431\u043b\u0435\u043c\u044b \u043c\u043e\u0436\u043d\u043e \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c \u043c\u0435\u0442\u043e\u0434 ",(0,r.kt)("inlineCode",{parentName:"p"},"\u041f\u043e\u043b\u0443\u0447\u0438\u0442\u044c"),", \u043a\u043e\u0442\u043e\u0440\u044b\u0439 \u0432\u043e\u0437\u0432\u0440\u0430\u0449\u0430\u0435\u0442 \u0442\u0435\u043a\u0443\u0449\u0435\u0435 \u0441\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u0435."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u041c\u043e\u043a\u0438\u0442\u043e.\u041e\u0431\u0443\u0447\u0435\u043d\u0438\u0435(\u041c\u043e\u0434\u0443\u043b\u044c)\n    .\u041a\u043e\u0433\u0434\u0430(\u041c\u043e\u0434\u0443\u043b\u044c.\u0421\u0434\u0435\u043b\u0430\u0442\u044c\u0427\u0442\u043e\u0422\u043e(\n        \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0421\u0442\u0440\u043e\u043a\u0430").\u041f\u043e\u043b\u0443\u0447\u0438\u0442\u044c(),\n        \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0427\u0438\u0441\u043b\u043e")))\n    .\u0412\u0435\u0440\u043d\u0443\u0442\u044c\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442(\u0420\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u04421);\n')),(0,r.kt)("p",null,"\u0422\u0430\u043a\u0430\u044f \u0436\u0435 \u0438\u0441\u0442\u043e\u0440\u0438\u044f \u043f\u0440\u0438 \u0441\u043e\u0445\u0440\u0430\u043d\u0435\u043d\u0438\u0435 \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u043e\u0432 \u0432 \u043f\u0435\u0440\u0435\u043c\u0435\u043d\u043d\u044b\u0435."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430\u0421\u0442\u0440\u043e\u043a\u0430 = \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0421\u0442\u0440\u043e\u043a\u0430");\n\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430\u0427\u0438\u0441\u043b\u043e = \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0427\u0438\u0441\u043b\u043e");\n')),(0,r.kt)("p",null,(0,r.kt)("inlineCode",{parentName:"p"},"\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430\u0421\u0442\u0440\u043e\u043a\u0430")," \u0438 ",(0,r.kt)("inlineCode",{parentName:"p"},"\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430\u0427\u0438\u0441\u043b\u043e")," \u0431\u0443\u0434\u0443\u0442 \u0440\u0430\u0432\u043d\u044b \u0438 \u0441\u043e\u0434\u0435\u0440\u0436\u0430\u0442\u044c \u043e\u0434\u0438\u043d\u0430\u043a\u043e\u0432\u044b\u0435 \u0443\u0441\u043b\u043e\u0432\u0438\u044f. \u041f\u0440\u043e\u0431\u043b\u0435\u043c\u0443 \u0442\u0430\u043a\u0436\u0435 \u043c\u043e\u0436\u043d\u043e \u043e\u0431\u043e\u0439\u0442\u0438 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u044f \u043c\u0435\u0442\u043e\u0434 ",(0,r.kt)("inlineCode",{parentName:"p"},"\u041f\u043e\u043b\u0443\u0447\u0438\u0442\u044c"),"."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-bsl"},'\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430\u0421\u0442\u0440\u043e\u043a\u0430 = \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0421\u0442\u0440\u043e\u043a\u0430").\u041f\u043e\u043b\u0443\u0447\u0438\u0442\u044c();\n\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430\u0427\u0438\u0441\u043b\u043e = \u042e\u0422\u0435\u0441\u0442.\u041f\u0440\u0435\u0434\u0438\u043a\u0430\u0442().\u0418\u043c\u0435\u0435\u0442\u0422\u0438\u043f("\u0427\u0438\u0441\u043b\u043e").\u041f\u043e\u043b\u0443\u0447\u0438\u0442\u044c();\n')),(0,r.kt)("h3",{id:"\u043e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438-\u0440\u0435\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0438"},"\u041e\u0441\u043e\u0431\u0435\u043d\u043d\u043e\u0441\u0442\u0438 \u0440\u0435\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0438"),(0,r.kt)("p",null,"\u0421\u0430\u043c \u043c\u043e\u0434\u0443\u043b\u044c \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u043e\u0432 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0435\u0442\u0441\u044f \u0442\u043e\u043b\u044c\u043a\u043e \u0434\u043b\u044f \u0444\u043e\u0440\u043c\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u044f \u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u0439/\u0443\u0441\u043b\u043e\u0432\u0438\u0439. "),(0,r.kt)("p",null,"\u0420\u0435\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0435\u0439 \u043f\u0440\u043e\u0432\u0435\u0440\u043e\u043a \u0438 \u0444\u043e\u0440\u043c\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435\u043c \u0443\u0441\u043b\u043e\u0432\u0438\u0439 \u0437\u0430\u043d\u0438\u043c\u0430\u044e\u0442\u0441\u044f \u0434\u0440\u0443\u0433\u0438\u0435 \u043c\u043e\u0434\u0443\u043b\u0438 \u0438 \u0432\u043e\u0437\u043c\u043e\u0436\u043d\u0430 \u0441\u0438\u0442\u0443\u0430\u0446\u0438\u044f, \u043a\u043e\u0433\u0434\u0430 \u043d\u0435\u043a\u043e\u0442\u043e\u0440\u044b\u0435 \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u044b \u0435\u0449\u0435 \u043d\u0435 \u0440\u0435\u0430\u043b\u0438\u0437\u043e\u0432\u0430\u043d\u044b \u0438\u043b\u0438 \u043d\u0435 \u043f\u043e\u0434\u0434\u0435\u0440\u0436\u0438\u0432\u0430\u044e\u0442\u0441\u044f \u043a\u0430\u043a\u0438\u043c-\u043b\u0438\u0431\u043e \u043c\u0435\u0445\u0430\u043d\u0438\u0437\u043c\u043e\u043c. \u041d\u0430\u043f\u0440\u0438\u043c\u0435\u0440, \u043f\u0440\u043e\u0432\u0435\u0440\u043a\u0430 \u0437\u0430\u043f\u043e\u043b\u043d\u0435\u043d\u043d\u043e\u0441\u0442\u0438 \u043d\u0435 \u043f\u043e\u0434\u0434\u0435\u0440\u0436\u0438\u0432\u0430\u0435\u0442\u0441\u044f \u0437\u0430\u043f\u0440\u043e\u0441\u0430\u043c\u0438."))}m.isMDXComponent=!0}}]);