"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[4787],{12194:(t,e,a)=>{a.r(e),a.d(e,{default:()=>h});a(96540);var s=a(34164),n=a(61213),r=a(17559),l=a(26820),c=a(62557),i=a(41463),o=a(51107),g=a(74848);function u(t){let{title:e}=t;return(0,g.jsxs)(g.Fragment,{children:[(0,g.jsx)(n.be,{title:e}),(0,g.jsx)(i.A,{tag:"doc_tags_list"})]})}function d(t){let{tags:e,title:a}=t;return(0,g.jsx)(n.e3,{className:(0,s.A)(r.G.page.docsTagsListPage),children:(0,g.jsx)("div",{className:"container margin-vert--lg",children:(0,g.jsx)("div",{className:"row",children:(0,g.jsxs)("main",{className:"col col--8 col--offset-2",children:[(0,g.jsx)(o.A,{as:"h1",children:a}),(0,g.jsx)(c.A,{tags:e})]})})})})}function h(t){const e=(0,l.b)();return(0,g.jsxs)(g.Fragment,{children:[(0,g.jsx)(u,{...t,title:e}),(0,g.jsx)(d,{...t,title:e})]})}},56133:(t,e,a)=>{a.d(e,{A:()=>c});a(96540);var s=a(34164),n=a(28774);const r={tag:"tag_zVej",tagRegular:"tagRegular_sFm0",tagWithCount:"tagWithCount_h2kH"};var l=a(74848);function c(t){let{permalink:e,label:a,count:c,description:i}=t;return(0,l.jsxs)(n.A,{href:e,title:i,className:(0,s.A)(r.tag,c?r.tagWithCount:r.tagRegular),children:[a,c&&(0,l.jsx)("span",{children:c})]})}},62557:(t,e,a)=>{a.d(e,{A:()=>o});a(96540);var s=a(26820),n=a(56133),r=a(51107);const l={tag:"tag_Nnez"};var c=a(74848);function i(t){let{letterEntry:e}=t;return(0,c.jsxs)("article",{children:[(0,c.jsx)(r.A,{as:"h2",id:e.letter,children:e.letter}),(0,c.jsx)("ul",{className:"padding--none",children:e.tags.map((t=>(0,c.jsx)("li",{className:l.tag,children:(0,c.jsx)(n.A,{...t})},t.permalink)))}),(0,c.jsx)("hr",{})]})}function o(t){let{tags:e}=t;const a=(0,s.Q)(e);return(0,c.jsx)("section",{className:"margin-vert--lg",children:a.map((t=>(0,c.jsx)(i,{letterEntry:t},t.letter)))})}},26820:(t,e,a)=>{a.d(e,{Q:()=>r,b:()=>n});var s=a(21312);const n=()=>(0,s.T)({id:"theme.tags.tagsPageTitle",message:"Tags",description:"The title of the tag list page"});function r(t){const e={};return Object.values(t).forEach((t=>{const a=function(t){return t[0].toUpperCase()}(t.label);e[a]??=[],e[a].push(t)})),Object.entries(e).sort(((t,e)=>{let[a]=t,[s]=e;return a.localeCompare(s)})).map((t=>{let[e,a]=t;return{letter:e,tags:a.sort(((t,e)=>t.label.localeCompare(e.label)))}}))}}}]);