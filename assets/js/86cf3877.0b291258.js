"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[7389],{58574:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>c,contentTitle:()=>a,default:()=>h,frontMatter:()=>r,metadata:()=>t,toc:()=>d});const t=JSON.parse('{"id":"getting-started/install/install","title":"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430","description":"YAxUnit - \u044d\u0442\u043e \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u0435 \u0434\u043b\u044f 1\u0421:\u041f\u0440\u0435\u0434\u043f\u0440\u0438\u044f\u0442\u0438\u044f, \u043a\u043e\u0442\u043e\u0440\u043e\u0435 \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e \u0434\u043e\u0431\u0430\u0432\u0438\u0442\u044c \u043a \u0432\u0430\u0448\u0435\u043c\u0443 \u043f\u0440\u043e\u0435\u043a\u0442\u0443.","source":"@site/docs/getting-started/install/install.md","sourceDirName":"getting-started/install","slug":"/getting-started/install/","permalink":"/yaxunit/docs/getting-started/install/","draft":false,"unlisted":false,"editUrl":"https://github.com/bia-technologies/yaxunit/docs/getting-started/install/install.md","tags":[{"inline":true,"label":"\u041d\u0430\u0447\u0430\u043b\u043e","permalink":"/yaxunit/docs/tags/\u043d\u0430\u0447\u0430\u043b\u043e"}],"version":"current","sidebarPosition":0,"frontMatter":{"sidebar_position":0,"tags":["\u041d\u0430\u0447\u0430\u043b\u043e"]},"sidebar":"tutorialSidebar","previous":{"title":"\u041d\u0430\u0447\u0430\u043b\u043e \u0440\u0430\u0431\u043e\u0442\u044b","permalink":"/yaxunit/docs/getting-started/"},"next":{"title":"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u043f\u043b\u0430\u0433\u0438\u043d\u0430 \u0434\u043b\u044f EDT","permalink":"/yaxunit/docs/getting-started/install/install-plugin"}}');var i=s(74848),l=s(28453);const r={sidebar_position:0,tags:["\u041d\u0430\u0447\u0430\u043b\u043e"]},a="\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430",c={},d=[{value:"\u0422\u0440\u0435\u0431\u043e\u0432\u0430\u043d\u0438\u044f",id:"\u0442\u0440\u0435\u0431\u043e\u0432\u0430\u043d\u0438\u044f",level:2},{value:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u0432 1\u0421 Development Tools (EDT)",id:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u0432-1\u0441-development-tools-edt",level:2},{value:"\u041f\u0435\u0440\u0432\u0438\u0447\u043d\u0430\u044f \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u0434\u0432\u0438\u0436\u043a\u0430 \u0432 \u0440\u0430\u0431\u043e\u0447\u0435\u0435 \u043f\u0440\u043e\u0441\u0442\u0440\u0430\u043d\u0441\u0442\u0432\u043e (workspace)",id:"\u043f\u0435\u0440\u0432\u0438\u0447\u043d\u0430\u044f-\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e-\u0434\u0432\u0438\u0436\u043a\u0430-\u0432-\u0440\u0430\u0431\u043e\u0447\u0435\u0435-\u043f\u0440\u043e\u0441\u0442\u0440\u0430\u043d\u0441\u0442\u0432\u043e-workspace",level:3},{value:"\u041e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435 \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u0434\u0432\u0438\u0436\u043a\u0430",id:"\u043e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435-\u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e-\u0434\u0432\u0438\u0436\u043a\u0430",level:3},{value:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u0432 \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0442\u043e\u0440",id:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u0432-\u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0442\u043e\u0440",level:2}];function o(e){const n={a:"a",admonition:"admonition",code:"code",h1:"h1",h2:"h2",h3:"h3",header:"header",img:"img",li:"li",ol:"ol",p:"p",strong:"strong",ul:"ul",...(0,l.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(n.header,{children:(0,i.jsx)(n.h1,{id:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430",children:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430"})}),"\n",(0,i.jsx)(n.p,{children:"YAxUnit - \u044d\u0442\u043e \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u0435 \u0434\u043b\u044f 1\u0421:\u041f\u0440\u0435\u0434\u043f\u0440\u0438\u044f\u0442\u0438\u044f, \u043a\u043e\u0442\u043e\u0440\u043e\u0435 \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e \u0434\u043e\u0431\u0430\u0432\u0438\u0442\u044c \u043a \u0432\u0430\u0448\u0435\u043c\u0443 \u043f\u0440\u043e\u0435\u043a\u0442\u0443."}),"\n",(0,i.jsx)(n.h2,{id:"\u0442\u0440\u0435\u0431\u043e\u0432\u0430\u043d\u0438\u044f",children:"\u0422\u0440\u0435\u0431\u043e\u0432\u0430\u043d\u0438\u044f"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"1\u0421:\u041f\u0440\u0435\u0434\u043f\u0440\u0438\u044f\u0442\u0438\u0435 \u0432\u0435\u0440\u0441\u0438\u0438 8.3.10 \u0438\u043b\u0438 \u0441\u0442\u0430\u0440\u0448\u0435"}),"\n"]}),"\n",(0,i.jsxs)(n.h2,{id:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u0432-1\u0441-development-tools-edt",children:["\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u0432 1\u0421",":Enterprise"," Development Tools (EDT)"]}),"\n",(0,i.jsx)(n.h3,{id:"\u043f\u0435\u0440\u0432\u0438\u0447\u043d\u0430\u044f-\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e-\u0434\u0432\u0438\u0436\u043a\u0430-\u0432-\u0440\u0430\u0431\u043e\u0447\u0435\u0435-\u043f\u0440\u043e\u0441\u0442\u0440\u0430\u043d\u0441\u0442\u0432\u043e-workspace",children:"\u041f\u0435\u0440\u0432\u0438\u0447\u043d\u0430\u044f \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u0434\u0432\u0438\u0436\u043a\u0430 \u0432 \u0440\u0430\u0431\u043e\u0447\u0435\u0435 \u043f\u0440\u043e\u0441\u0442\u0440\u0430\u043d\u0441\u0442\u0432\u043e (workspace)"}),"\n",(0,i.jsxs)(n.ol,{children:["\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsxs)(n.p,{children:["\u0421\u043a\u0430\u0447\u0430\u0435\u043c \u0430\u0440\u0445\u0438\u0432 ",(0,i.jsx)(n.a,{href:"https://github.com/bia-technologies/yaxunit/releases/latest",children:"\u0440\u0435\u043b\u0438\u0437\u0430"}),"\n",(0,i.jsx)(n.img,{alt:"\u0421\u0442\u0440\u0430\u043d\u0438\u0446\u0430 \u0440\u0435\u043b\u0438\u0437\u0430",src:s(73664).A+"",width:"861",height:"893"})]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsxs)(n.p,{children:["\u041a\u043e\u043f\u0438\u0440\u0443\u0435\u043c \u0438\u0437 \u0430\u0440\u0445\u0438\u0432\u0430 \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u0435 \u0440\u0430\u0441\u043f\u043e\u043b\u043e\u0436\u0435\u043d\u043d\u043e\u0435 \u0432 \u043a\u0430\u0442\u0430\u043b\u043e\u0433\u0435 ",(0,i.jsx)(n.code,{children:"exts/yaxunit/"})," \u0432 \u0441\u0432\u043e\u0439 \u043a\u0430\u0442\u0430\u043b\u043e\u0433 \u0441 \u0438\u0441\u0445\u043e\u0434\u043d\u0438\u043a\u0430\u043c\u0438 (\u043d\u0435 \u0432 workspace)\n",(0,i.jsx)(n.img,{alt:"\u0421\u043e\u0434\u0435\u0440\u0436\u0438\u043c\u043e\u0435 \u0430\u0440\u0445\u0438\u0432\u0430",src:s(7528).A+"",width:"865",height:"271"})]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsxs)(n.p,{children:["\u0418\u043c\u043f\u043e\u0440\u0442\u0438\u0440\u0443\u0435\u043c \u043f\u0440\u043e\u0435\u043a\u0442 \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u044f \u0432 workspace\n",(0,i.jsx)(n.img,{alt:"\u0418\u043c\u043f\u043e\u0440\u0442 \u043f\u0440\u043e\u0435\u043a\u0442\u0430",src:s(62170).A+"",width:"1081",height:"627"})]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsxs)(n.p,{children:["\u041f\u0440\u0438\u0432\u044f\u0437\u044b\u0432\u0430\u0435\u043c \u0438\u043c\u043f\u043e\u0440\u0442\u0438\u0440\u043e\u0432\u0430\u043d\u043d\u044b\u0439 \u043f\u0440\u043e\u0435\u043a\u0442 \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u044f \u043a \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0446\u0438\u0438\n",(0,i.jsx)(n.img,{alt:"\u0421\u0432\u044f\u0437\u044c \u0441 \u0431\u0430\u0437\u043e\u0432\u044b\u043c \u043f\u0440\u043e\u0435\u043a\u0442\u043e\u043c",src:s(42283).A+"",width:"1076",height:"369"})]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsx)(n.p,{children:"\u041e\u0431\u043d\u043e\u0432\u043b\u044f\u0435\u043c \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0446\u0438\u044e"}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsxs)(n.p,{children:["\u0412 \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0442\u043e\u0440\u0435 \u0441\u043d\u0438\u043c\u0430\u0435\u043c \u0441 \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u044f ",(0,i.jsx)(n.strong,{children:"\u0431\u0435\u0437\u043e\u043f\u0430\u0441\u043d\u044b\u0439 \u0440\u0435\u0436\u0438\u043c"})," \u0438 ",(0,i.jsx)(n.strong,{children:"\u0437\u0430\u0449\u0438\u0442\u0443 \u043e\u0442 \u043e\u043f\u0430\u0441\u043d\u044b\u0445 \u0434\u0435\u0439\u0441\u0442\u0432\u0438\u0439"})]}),"\n"]}),"\n",(0,i.jsxs)(n.li,{children:["\n",(0,i.jsx)(n.p,{children:"\u0413\u043e\u0442\u043e\u0432\u043e, \u043c\u043e\u0436\u043d\u043e \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0438\u0442\u044c \u043a \u043d\u0430\u043f\u0438\u0441\u0430\u043d\u0438\u044e \u0442\u0435\u0441\u0442\u043e\u0432."}),"\n",(0,i.jsx)(n.admonition,{title:"\u0441\u043e\u0432\u0435\u0442",type:"tip",children:(0,i.jsxs)(n.p,{children:["\u0414\u043b\u044f \u0443\u0434\u043e\u0431\u0441\u0442\u0432\u0430 \u0440\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u043a\u0438 \u0442\u0435\u0441\u0442\u043e\u0432 \u0440\u0435\u043a\u043e\u043c\u0435\u043d\u0434\u0443\u0435\u0442\u0441\u044f ",(0,i.jsx)(n.a,{href:"/yaxunit/docs/getting-started/install/install-plugin",children:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u0438\u0442\u044c \u043f\u043b\u0430\u0433\u0438\u043d"})]})}),"\n"]}),"\n"]}),"\n",(0,i.jsx)(n.h3,{id:"\u043e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435-\u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e-\u0434\u0432\u0438\u0436\u043a\u0430",children:"\u041e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435 \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u0434\u0432\u0438\u0436\u043a\u0430"}),"\n",(0,i.jsxs)(n.ol,{children:["\n",(0,i.jsxs)(n.li,{children:["\u0421\u043a\u0430\u0447\u0430\u0435\u043c \u0430\u0440\u0445\u0438\u0432 ",(0,i.jsx)(n.a,{href:"https://github.com/bia-technologies/yaxunit/releases/latest",children:"\u0440\u0435\u043b\u0438\u0437\u0430"})]}),"\n",(0,i.jsx)(n.li,{children:"\u0415\u0441\u043b\u0438 \u0432\u044b \u0434\u043e\u0440\u0430\u0431\u0430\u0442\u044b\u0432\u0430\u043b\u0438 \u0434\u0432\u0438\u0436\u043e\u043a, \u0442\u043e \u0441\u043a\u0430\u0447\u0438\u0432\u0430\u0435\u043c \u0430\u0440\u0445\u0438\u0432 \u043e\u0440\u0438\u0433\u0438\u043d\u0430\u043b\u044c\u043d\u043e\u0439 \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043b\u0435\u043d\u043d\u043e\u0439 \u0432\u0435\u0440\u0441\u0438\u0438 \u0434\u0432\u0438\u0436\u043a\u0430"}),"\n",(0,i.jsx)(n.li,{children:"\u0420\u0430\u0437\u0430\u0440\u0445\u0438\u0432\u0438\u0440\u0443\u0435\u043c \u0438\u0445 \u0432\u043e \u0432\u0440\u0435\u043c\u0435\u043d\u043d\u044b\u0439 \u043a\u0430\u0442\u0430\u043b\u043e\u0433"}),"\n",(0,i.jsxs)(n.li,{children:["\u0412\u043e\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0435\u043c\u0441\u044f \u043c\u0435\u0445\u0430\u043d\u0438\u0437\u043c\u043e\u043c \u0441\u0440\u0430\u0432\u043d\u0435\u043d\u0438\u044f \u043e\u0431\u044a\u0435\u0434\u0438\u043d\u0435\u043d\u0438\u044f EDT\n",(0,i.jsx)(n.img,{alt:"\u0421\u0440\u0430\u0432\u043d\u0435\u043d\u0438\u0435 \u043e\u0431\u044a\u0435\u0434\u0438\u043d\u0435\u043d\u0438\u0435",src:s(24932).A+"",width:"1171",height:"684"}),"\n",(0,i.jsxs)(n.ul,{children:["\n",(0,i.jsx)(n.li,{children:"\u0412\u0442\u043e\u0440\u043e\u0439 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a - \u043a\u0430\u0442\u0430\u043b\u043e\u0433 \u043a \u043d\u043e\u0432\u043e\u0439 \u0432\u0435\u0440\u0441\u0438\u0438 \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u0434\u0432\u0438\u0436\u043a\u0430"}),"\n",(0,i.jsx)(n.li,{children:"\u0418\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u0435 \u0442\u0440\u0435\u0442\u044c\u0435\u0433\u043e \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a\u0430 \u043d\u0443\u0436\u043d\u043e \u0434\u043b\u044f \u0442\u0440\u0435\u0445\u0441\u0442\u043e\u0440\u043e\u043d\u043d\u0435\u0433\u043e \u0441\u0440\u0430\u0432\u043d\u0435\u043d\u0438\u044f \u0438 \u043f\u0440\u0438\u043c\u0435\u043d\u044f\u0435\u0442\u0441\u044f \u043f\u0440\u0438 \u0434\u043e\u0440\u0430\u0431\u043e\u0442\u043a\u0430\u0445 \u0434\u0432\u0438\u0436\u043a\u0430."}),"\n"]}),"\n"]}),"\n",(0,i.jsx)(n.li,{children:'\u041d\u0430\u0436\u0438\u043c\u0430\u0435\u043c "\u041e\u0431\u044a\u0435\u0434\u0438\u043d\u0438\u0442\u044c"'}),"\n",(0,i.jsx)(n.li,{children:"\u0413\u043e\u0442\u043e\u0432\u043e."}),"\n"]}),"\n",(0,i.jsx)(n.h2,{id:"\u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430-\u0432-\u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0442\u043e\u0440",children:"\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 \u0432 \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0442\u043e\u0440"}),"\n",(0,i.jsxs)(n.ol,{children:["\n",(0,i.jsxs)(n.li,{children:["\u0421\u043a\u0430\u0447\u0430\u0435\u043c \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u0435 (cfe) ",(0,i.jsx)(n.a,{href:"https://github.com/bia-technologies/yaxunit/releases/latest",children:"\u0440\u0435\u043b\u0438\u0437\u0430"}),"\n",(0,i.jsx)(n.img,{alt:"\u0421\u0442\u0440\u0430\u043d\u0438\u0446\u0430 \u0440\u0435\u043b\u0438\u0437\u0430",src:s(73664).A+"",width:"861",height:"893"})]}),"\n",(0,i.jsx)(n.li,{children:"\u0417\u0430\u0433\u0440\u0443\u0436\u0430\u0435\u043c \u0432 \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0442\u043e\u0440"}),"\n",(0,i.jsxs)(n.li,{children:["\u0421\u043d\u0438\u043c\u0430\u0435\u043c \u0441 \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u044f ",(0,i.jsx)(n.strong,{children:"\u0431\u0435\u0437\u043e\u043f\u0430\u0441\u043d\u044b\u0439 \u0440\u0435\u0436\u0438\u043c"})," \u0438 ",(0,i.jsx)(n.strong,{children:"\u0437\u0430\u0449\u0438\u0442\u0443 \u043e\u0442 \u043e\u043f\u0430\u0441\u043d\u044b\u0445 \u0434\u0435\u0439\u0441\u0442\u0432\u0438\u0439"})]}),"\n",(0,i.jsx)(n.li,{children:"\u0413\u043e\u0442\u043e\u0432\u043e"}),"\n"]})]})}function h(e={}){const{wrapper:n}={...(0,l.R)(),...e.components};return n?(0,i.jsx)(n,{...e,children:(0,i.jsx)(o,{...e})}):o(e)}},24932:(e,n,s)=>{s.d(n,{A:()=>t});const t=s.p+"assets/images/compare-a752a84a3e1ca6f00a80776f5df034da.png"},7528:(e,n,s)=>{s.d(n,{A:()=>t});const t=s.p+"assets/images/gh-release-content-2b422b831aa4e3587f88cae3c9af188e.png"},73664:(e,n,s)=>{s.d(n,{A:()=>t});const t=s.p+"assets/images/gh-release-352caaca6f7c417c12517dd9aac41d86.png"},42283:(e,n,s)=>{s.d(n,{A:()=>t});const t=s.p+"assets/images/link-base-project-6ca4ed117c5fcacc95fa022f8a56d404.png"},62170:(e,n,s)=>{s.d(n,{A:()=>t});const t=s.p+"assets/images/project-import-7d0b8692c50b037424c55772779956bb.png"},28453:(e,n,s)=>{s.d(n,{R:()=>r,x:()=>a});var t=s(96540);const i={},l=t.createContext(i);function r(e){const n=t.useContext(l);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function a(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(i):e.components||i:r(e.components),t.createElement(l.Provider,{value:n},e.children)}}}]);