"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[6916],{5788:(e,t,n)=>{n.d(t,{Iu:()=>c,yg:()=>g});var r=n(1504);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function l(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?l(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):l(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function o(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},l=Object.keys(e);for(r=0;r<l.length;r++)n=l[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var l=Object.getOwnPropertySymbols(e);for(r=0;r<l.length;r++)n=l[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var u=r.createContext({}),s=function(e){var t=r.useContext(u),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},c=function(e){var t=s(e.components);return r.createElement(u.Provider,{value:t},e.children)},p="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,l=e.originalType,u=e.parentName,c=o(e,["components","mdxType","originalType","parentName"]),p=s(n),d=a,g=p["".concat(u,".").concat(d)]||p[d]||m[d]||l;return n?r.createElement(g,i(i({ref:t},c),{},{components:n})):r.createElement(g,i({ref:t},c))}));function g(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var l=n.length,i=new Array(l);i[0]=d;var o={};for(var u in t)hasOwnProperty.call(t,u)&&(o[u]=t[u]);o.originalType=e,o[p]="string"==typeof e?e:a,i[1]=o;for(var s=2;s<l;s++)i[s]=n[s];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}d.displayName="MDXCreateElement"},6880:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>k,contentTitle:()=>I,default:()=>P,frontMatter:()=>O,metadata:()=>x,toc:()=>V});var r=n(5072),a=n(1504),l=n(5788),i=n(4971),o=n(3943),u=n(5592),s=n(632),c=n(7128),p=n(1148);function m(e){return function(e){return a.Children.map(e,(e=>{if((0,a.isValidElement)(e)&&"value"in e.props)return e;throw new Error(`Docusaurus error: Bad <Tabs> child <${"string"==typeof e.type?e.type:e.type.name}>: all children of the <Tabs> component should be <TabItem>, and every <TabItem> should have a unique "value" prop.`)}))}(e).map((e=>{let{props:{value:t,label:n,attributes:r,default:a}}=e;return{value:t,label:n,attributes:r,default:a}}))}function d(e){const{values:t,children:n}=e;return(0,a.useMemo)((()=>{const e=t??m(n);return function(e){const t=(0,c.w)(e,((e,t)=>e.value===t.value));if(t.length>0)throw new Error(`Docusaurus error: Duplicate values "${t.map((e=>e.value)).join(", ")}" found in <Tabs>. Every value needs to be unique.`)}(e),e}),[t,n])}function g(e){let{value:t,tabValues:n}=e;return n.some((e=>e.value===t))}function y(e){let{queryString:t=!1,groupId:n}=e;const r=(0,u.Uz)(),l=function(e){let{queryString:t=!1,groupId:n}=e;if("string"==typeof t)return t;if(!1===t)return null;if(!0===t&&!n)throw new Error('Docusaurus error: The <Tabs> component groupId prop is required if queryString=true, because this value is used as the search param name. You can also provide an explicit value such as queryString="my-search-param".');return n??null}({queryString:t,groupId:n});return[(0,s._M)(l),(0,a.useCallback)((e=>{if(!l)return;const t=new URLSearchParams(r.location.search);t.set(l,e),r.replace({...r.location,search:t.toString()})}),[l,r])]}function b(e){const{defaultValue:t,queryString:n=!1,groupId:r}=e,l=d(e),[i,o]=(0,a.useState)((()=>function(e){let{defaultValue:t,tabValues:n}=e;if(0===n.length)throw new Error("Docusaurus error: the <Tabs> component requires at least one <TabItem> children component");if(t){if(!g({value:t,tabValues:n}))throw new Error(`Docusaurus error: The <Tabs> has a defaultValue "${t}" but none of its children has the corresponding value. Available values are: ${n.map((e=>e.value)).join(", ")}. If you intend to show no default tab, use defaultValue={null} instead.`);return t}const r=n.find((e=>e.default))??n[0];if(!r)throw new Error("Unexpected error: 0 tabValues");return r.value}({defaultValue:t,tabValues:l}))),[u,s]=y({queryString:n,groupId:r}),[c,m]=function(e){let{groupId:t}=e;const n=function(e){return e?`docusaurus.tab.${e}`:null}(t),[r,l]=(0,p.IN)(n);return[r,(0,a.useCallback)((e=>{n&&l.set(e)}),[n,l])]}({groupId:r}),b=(()=>{const e=u??c;return g({value:e,tabValues:l})?e:null})();(0,a.useLayoutEffect)((()=>{b&&o(b)}),[b]);return{selectedValue:i,selectValue:(0,a.useCallback)((e=>{if(!g({value:e,tabValues:l}))throw new Error(`Can't select invalid tab value=${e}`);o(e),s(e),m(e)}),[s,m,l]),tabValues:l}}var f=n(3664);const h={tabList:"tabList__CuJ",tabItem:"tabItem_LNqP"};function v(e){let{className:t,block:n,selectedValue:l,selectValue:u,tabValues:s}=e;const c=[],{blockElementScrollPositionUntilNextRender:p}=(0,o.MV)(),m=e=>{const t=e.currentTarget,n=c.indexOf(t),r=s[n].value;r!==l&&(p(t),u(r))},d=e=>{let t=null;switch(e.key){case"Enter":m(e);break;case"ArrowRight":{const n=c.indexOf(e.currentTarget)+1;t=c[n]??c[0];break}case"ArrowLeft":{const n=c.indexOf(e.currentTarget)-1;t=c[n]??c[c.length-1];break}}t?.focus()};return a.createElement("ul",{role:"tablist","aria-orientation":"horizontal",className:(0,i.c)("tabs",{"tabs--block":n},t)},s.map((e=>{let{value:t,label:n,attributes:o}=e;return a.createElement("li",(0,r.c)({role:"tab",tabIndex:l===t?0:-1,"aria-selected":l===t,key:t,ref:e=>c.push(e),onKeyDown:d,onClick:m},o,{className:(0,i.c)("tabs__item",h.tabItem,o?.className,{"tabs__item--active":l===t})}),n??t)})))}function N(e){let{lazy:t,children:n,selectedValue:r}=e;if(n=Array.isArray(n)?n:[n],t){const e=n.find((e=>e.props.value===r));return e?(0,a.cloneElement)(e,{className:"margin-top--md"}):null}return a.createElement("div",{className:"margin-top--md"},n.map(((e,t)=>(0,a.cloneElement)(e,{key:t,hidden:e.props.value!==r}))))}function E(e){const t=b(e);return a.createElement("div",{className:(0,i.c)("tabs-container",h.tabList)},a.createElement(v,(0,r.c)({},e,t)),a.createElement(N,(0,r.c)({},e,t)))}function T(e){const t=(0,f.c)();return a.createElement(E,(0,r.c)({key:String(t)},e))}const w={tabItem:"tabItem_Ymn6"};function D(e){let{children:t,hidden:n,className:r}=e;return a.createElement("div",{role:"tabpanel",className:(0,i.c)(w.tabItem,r),hidden:n},t)}const O={sidebar_position:2,sidebar_label:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 EDT"},I="\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 \u0434\u043b\u044f \u0440\u0430\u0431\u043e\u0442\u044b \u0441 \u0442\u0435\u0441\u0442\u0430\u043c\u0438 \u0432 EDT",x={unversionedId:"install/install-plugin",id:"install/install-plugin",title:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 \u0434\u043b\u044f \u0440\u0430\u0431\u043e\u0442\u044b \u0441 \u0442\u0435\u0441\u0442\u0430\u043c\u0438 \u0432 EDT",description:"\u0414\u043b\u044f \u0442\u043e\u0433\u043e, \u0447\u0442\u043e \u0431\u044b \u0432\u0430\u043c \u0438 \u043d\u0430\u043c \u0431\u044b\u043b\u043e \u043f\u0440\u043e\u0449\u0435 \u043f\u0438\u0441\u0430\u0442\u044c \u0442\u0435\u0441\u0442\u044b \u043c\u044b \u0440\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u0430\u043b\u0438 \u043f\u043b\u0430\u0433\u0438\u043d \u0434\u043b\u044f EDT.",source:"@site/docs/install/install-plugin.md",sourceDirName:"install",slug:"/install/install-plugin",permalink:"/yaxunit/docs/install/install-plugin",draft:!1,editUrl:"https://github.com/bia-technologies/yaxunit/docs/install/install-plugin.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2,sidebar_label:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 EDT"},sidebar:"tutorialSidebar",previous:{title:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430",permalink:"/yaxunit/docs/install/"},next:{title:"\u041f\u0438\u0448\u0435\u043c \u043f\u0435\u0440\u0432\u044b\u0439 \u0442\u0435\u0441\u0442",permalink:"/yaxunit/docs/first-test"}},k={},V=[],j={toc:V},C="wrapper";function P(e){let{components:t,...a}=e;return(0,l.yg)(C,(0,r.c)({},j,a,{components:t,mdxType:"MDXLayout"}),(0,l.yg)("h1",{id:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u043f\u043b\u0430\u0433\u0438\u043d\u0430-\u0434\u043b\u044f-\u0440\u0430\u0431\u043e\u0442\u044b-\u0441-\u0442\u0435\u0441\u0442\u0430\u043c\u0438-\u0432-edt"},"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 \u0434\u043b\u044f \u0440\u0430\u0431\u043e\u0442\u044b \u0441 \u0442\u0435\u0441\u0442\u0430\u043c\u0438 \u0432 EDT"),(0,l.yg)("p",null,"\u0414\u043b\u044f \u0442\u043e\u0433\u043e, \u0447\u0442\u043e \u0431\u044b \u0432\u0430\u043c \u0438 \u043d\u0430\u043c \u0431\u044b\u043b\u043e \u043f\u0440\u043e\u0449\u0435 \u043f\u0438\u0441\u0430\u0442\u044c \u0442\u0435\u0441\u0442\u044b \u043c\u044b \u0440\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u0430\u043b\u0438 \u043f\u043b\u0430\u0433\u0438\u043d \u0434\u043b\u044f EDT."),(0,l.yg)("p",null,"\u0421 \u0435\u0433\u043e \u043f\u043e\u043c\u043e\u0449\u044c\u044e \u0432\u044b \u0441\u043c\u043e\u0436\u0435\u0442\u0435:"),(0,l.yg)("ul",null,(0,l.yg)("li",{parentName:"ul"},"\u0417\u0430\u043f\u0443\u0441\u043a\u0430\u0442\u044c \u0438 \u043e\u0442\u043b\u0430\u0436\u0438\u0432\u0430\u0442\u044c \u0441\u0432\u043e\u0438 \u0442\u0435\u0441\u0442\u044b;"),(0,l.yg)("li",{parentName:"ul"},"\u041f\u0440\u043e\u0441\u043c\u0430\u0442\u0440\u0438\u0432\u0430\u0442\u044c \u0440\u0435\u0437\u0443\u043b\u044c\u0442\u0430\u0442\u044b \u0432\u044b\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u044f."),(0,l.yg)("li",{parentName:"ul"},"\u0418 ",(0,l.yg)("a",{parentName:"li",href:"https://github.com/bia-technologies/edt-test-runner/blob/develop/docs/%D0%A4%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%B8.md"},"\u0447\u0442\u043e-\u0442\u043e \u0435\u0449\u0435"))),(0,l.yg)("p",null,"\u0414\u043b\u044f \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0438 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 \u0432\u0430\u043c \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e \u0432\u043e\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c\u0441\u044f \u0441\u0442\u0430\u043d\u0434\u0430\u0440\u0442\u043d\u044b\u043c \u0444\u0443\u043d\u043a\u0446\u0438\u043e\u043d\u0430\u043b\u043e\u043c Eclipse (EDT) ",(0,l.yg)("inlineCode",{parentName:"p"},"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u0438\u0442\u044c \u043d\u043e\u0432\u043e\u0435 \u041f\u041e..."),"."),(0,l.yg)("ul",null,(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u041e\u0442\u043a\u0440\u044b\u0432\u0430\u0435\u043c EDT. ")),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u041f\u0435\u0440\u0435\u0445\u043e\u0434\u0438\u043c \u043a ",(0,l.yg)("inlineCode",{parentName:"p"},"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u0438\u0442\u044c \u043d\u043e\u0432\u043e\u0435 \u041f\u041e")," (\u0432 \u043c\u0435\u043d\u044e ",(0,l.yg)("inlineCode",{parentName:"p"},"\u0421\u043f\u0440\u0430\u0432\u043a\u0430"),");")),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u0414\u043e\u0431\u0430\u0432\u043b\u044f\u0435\u043c \u043d\u043e\u0432\u044b\u0439 \u0440\u0435\u043f\u043e\u0437\u0438\u0442\u043e\u0440\u0438\u0439;"),(0,l.yg)(T,{mdxType:"Tabs"},(0,l.yg)(D,{value:"master",label:"\u041e\u0441\u043d\u043e\u0432\u043d\u043e\u0439 \u0440\u0435\u043f\u043e\u0437\u0438\u0442\u043e\u0440\u0438\u0439",mdxType:"TabItem"},(0,l.yg)("pre",{parentName:"li"},(0,l.yg)("code",{parentName:"pre",className:"language-url"},"https://bia-technologies.github.io/edt-test-runner/repository\n"))),(0,l.yg)(D,{value:"develop",label:"Develop",mdxType:"TabItem"},(0,l.yg)("pre",{parentName:"li"},(0,l.yg)("code",{parentName:"pre",className:"language-url"},"https://bia-technologies.github.io/edt-test-runner/dev/repository\n")))),(0,l.yg)("p",{parentName:"li"},(0,l.yg)("img",{alt:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430",src:n(5973).c,width:"940",height:"512"})),(0,l.yg)("admonition",{parentName:"li",title:"\u0441\u043e\u0432\u0435\u0442",type:"tip"},(0,l.yg)("p",{parentName:"admonition"},"\u0414\u043b\u044f \u0443\u0441\u043a\u043e\u0440\u0435\u043d\u0438\u044f \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0438 \u043c\u043e\u0436\u043d\u043e \u0443\u0431\u0440\u0430\u0442\u044c \u0433\u0430\u043b\u043e\u0447\u043a\u0443 ",(0,l.yg)("inlineCode",{parentName:"p"},"\u041e\u0431\u0440\u0430\u0449\u0430\u0442\u044c\u0441\u044f \u0432\u043e \u0432\u0440\u0435\u043c\u044f \u0438\u043d\u0441\u0442\u0430\u043b\u043b\u044f\u0446\u0438\u0438 \u043a\u043e \u0432\u0441\u0435\u043c \u0441\u0430\u0439\u0442\u0430\u043c ...")))),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u041d\u0430\u0436\u0438\u043c\u0430\u0435\u043c \u0434\u0430\u043b\u0435\u0435;")),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u041f\u0440\u0438\u043d\u0438\u043c\u0430\u0435\u043c \u043b\u0438\u0446\u0435\u043d\u0437\u0438\u044e;")),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u0421\u043e\u0433\u043b\u0430\u0448\u0430\u0435\u043c\u0441\u044f \u0441 \u043f\u0440\u0435\u0434\u0443\u043f\u0440\u0435\u0436\u0434\u0435\u043d\u0438\u0435\u043c \u0431\u0435\u0437\u043e\u043f\u0430\u0441\u043d\u043e\u0441\u0442\u0438;")),(0,l.yg)("li",{parentName:"ul"},(0,l.yg)("p",{parentName:"li"},"\u0418 \u043f\u0435\u0440\u0435\u0437\u0430\u0433\u0440\u0443\u0436\u0430\u0435\u043c IDE."),(0,l.yg)("admonition",{parentName:"li",title:"\u043f\u0440\u0438\u043c\u0435\u0447\u0430\u043d\u0438\u0435",type:"note"},(0,l.yg)("p",{parentName:"admonition"},"EDT \u0431\u0443\u0434\u0435\u0442 \u0434\u043e\u043b\u0433\u043e \u043f\u0435\u0440\u0435\u0437\u0430\u0433\u0440\u0443\u0436\u0430\u0442\u044c\u0441\u044f \u0438 \u044d\u0442\u043e \u043d\u043e\u0440\u043c\u0430\u043b\u044c\u043d\u043e.")))))}P.isMDXComponent=!0},5973:(e,t,n)=>{n.d(t,{c:()=>r});const r=n.p+"assets/images/plugin-install-from-rep-a3b9e909d84edff8dc96c44f806241cf.png"}}]);