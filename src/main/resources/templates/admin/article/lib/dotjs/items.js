ory];d=a&&a.name||""}u.pack(l,e,t,i.data,i.rawIndex,i.data.name||"",i.category),this.shapeList.push(l),this.zr.addShape(l),i.shape=l},this)},_buildLinkShapes:function(e,t){for(var i=this._graph,n=i.edges.length,a=0;n>a;a++){var o=i.edges[a],r=o.data,s=o.node1,l=o.node2,c=i.getEdge(l,s),m=this._getEdgeQueryTarget(e,r),y=this.deepQuery(m,"type");e.linkSymbol&&"none"!==e.linkSymbol&&(y="line");var f="line"===y?h:d,V=new f({style:{xStart:0,yStart:0,xEnd:0,yEnd:0},clickable:this.query(e,"clickable"),highlightStyle:{},zlevel:this.getZlevelBase(),z:this.getZBase()});if(c&&c.shape&&(V.style.offset=4,c.shape.style.offset=4),g.merge(V.style,this.query(e,"itemStyle.normal.linkStyle"),!0),g.merge(V.highlightStyle,this.query(e,"itemStyle.emphasis.linkStyle"),!0),"undefined"!=typeof r.itemStyle&&(r.itemStyle.normal&&g.merge(V.style,r.itemStyle.normal,!0),r.itemStyle.emphasis&&g.merge(V.highlightStyle,r.itemStyle.emphasis,!0)),V.style.lineWidth=V.style.lineWidth||V.style.width,V.style.strokeColor=V.style.strokeColor||V.style.color,V.highlightStyle.lineWidth=V.highlightStyle.lineWidth||V.highlightStyle.width,V.highlightStyle.strokeColor=V.highlightStyle.strokeColor||V.highlightStyle.color,u.pack(V,e,t,o.data,null==o.rawIndex?a:o.rawIndex,o.data.name||s.id+" - "+l.id,s.id,l.id),this.shapeList.push(V),this.zr.addShape(V),o.shape=V,e.linkSymbol&&"none"!==e.linkSymbol){var U=new p({style:{x:-5,y:0,width:e.linkSymbolSize[0],height:e.linkSymbolSize[1],iconType:e.linkSymbol,brushType:"fill",color:V.style.strokeColor},highlightStyle:{brushType:"fill"},position:[0,0],rotation:0,zlevel:this.getZlevelBase(),z:this.getZBase()});V._symbolShape=U,this.shapeList.push(U),this.zr.addShape(U)}}},_updateLinkShapes:function(){for(var e=f.create(),t=f.create(),i=f.create(),n=f.create(),a=this._graph.edges,o=0,r=a.length;r>o;o++){var s=a[o],l=s.node1.shape,h=s.node2.shape;f.copy(i,l.position),f.copy(n,h.position);var d=s.shape.style;if(f.sub(e,i,n),f.normalize(e,e),d.offset?(t[0]=e[1],t[1]=-e[0],f.scaleAndAdd(i,i,t,d.offset),f.scaleAndAdd(n,n,t,d.offset)):"bezier-curve"===s.shape.type&&(d.cpX1=(i[0]+n[0])/2-(n[1]-i[1])/4,d.cpY1=(i[1]+n[1])/2-(i[0]-n[0])/4),d.xStart=i[0],d.yStart=i[1],d.xEnd=n[0],d.yEnd=n[1],s.shape.modSelf(),s.shape._symbolShape){var c=s.shape._symbolShape;f.copy(c.position,n),f.scaleAndAdd(c.position,c.position,e,h.style.width/2+2);var p=Math.atan2(e[1],e[0]);c.rotation=Math.PI/2-p,c.modSelf()}}},_syncNodePositions:function(){for(var e=this._graph,t=0;t<e.nodes.length;t++){var i=e.nodes[t],n=i.layout.position,a=i.data,o=i.shape,r=o.fixed||a.fixX,s=o.fixed||a.fixY;r===!0?r=1:isNaN(r)&&(r=0),s===!0?s=1:isNaN(s)&&(s=0),o.position[0]+=(n[0]-o.position[0])*(1-r),o.position[1]+=(n[1]-o.position[1])*(1-s),f.copy(n,o.position);var l=a.name;if(l){var h=this.__nodePositionMap[l];h||(h=this.__nodePositionMap[l]=f.create()),f.copy(h,n)}o.modSelf()}},_step:function(){this._syncNodePositions(),this._updateLinkShapes(),this.zr.refreshNextFrame(),this._layout.temperature>.01?this._layout.step(this._steps):this.messageCenter.dispatch(m.EVENT.FORCE_LAYOUT_END,{},{},this.myChart)},refresh:function(e){if(e&&(this.option=e,this.series=this.option.series),this.legend=this.component.legend,this.legend)this.getColor=function(e){return this.legend.getColor(e)},this.isSelected=function(e){return this.legend.isSelected(e)};else{var t={},i=0;this.getColor=function(e){return t[e]?t[e]:(t[e]||(t[e]=this.zr.getColor(i++)),t[e])},this.isSelected=function(){return!0}}this._init()},dispose:function(){this.clear(),this.shapeList=null,this.effectList=null,this._layout.dispose(),this._layout=null,this.__nodePositionMap={}},getPosition:function(){var e=[];return this._graph.eachNode(function(t){t.layout&&e.push({name:t.data.name,position:Array.prototype.slice.call(t.layout.position)})}),e}},g.inherits(t,r),e("../chart").define("force",t),t}),define("echarts/data/Graph",["require","zrender/tool/util"],function(e){var t=e("zrender/tool/util"),i=function(e){this._directed=e||!1,this.nodes=[],this.edges=[],this._nodesMap={},this._edgesMap={}};i.prototype.isDirected=function(){return this._directed},i.prototype.addNode=function(e,t){if(this._nodesMap[e])return this._nodesMap[e];var n=new i.Node(e,t);return this.nodes.push(n),this._nodesMap[e]=n,n},i.prototype.getNodeById=function(e){return this._nodesMap[e]},i.prototype.addEdge=function(e,t,n){if("string"==typeof e&&(e=this._nodesMap[e]),"string"==typeof t&&(t=this._nodesMap[t]),e&&t){var a=e.id+"-"+t.id;if(this._edgesMap[a])return this._edgesMap[a];var o=new i.Edge(e,t,n);return this._directed&&(e.outEdges.push(o),t.inEdges.push(o)),e.edges.push(o),e!==t&&t.edges.push(o),this.edges.push(o),this._edgesMap[a]=o,o}},i.prototype.removeEdge=function(e){var i=e.node1,n=e.node2,a=i.id+"-"+n.id;this._directed&&(i.outEdges.splice(t.indexOf(i.outEdges,e),1),n.inEdges.splice(t.indexOf(n.inEdges,e),1)),i.edges.splice(t.indexOf(i.edges,e),1),i!==n&&n.edges.splice(t.indexOf(n.edges,e),1),delete this._edgesMap[a],this.edges.splice(t.indexOf(this.edges,e),1)},i.prototype.getEdge=function(e,t){return"string"!=typeof e&&(e=e.id),"string"!=typeof t&&(t=t.id),this._directed?this._edgesMap[e+"-"+t]:this._edgesMap[e+"-"+t]||this._edgesMap[t+"-"+e]},i.prototype.removeNode=function(e){if("string"!=typeof e||(e=this._nodesMap[e])){delete this._nodesMap[e.id],this.nodes.splice(t.indexOf(this.nodes,e),1);for(var i=0;i<this.edges.length;){var n=this.edges[i];n.node1===e||n.node2===e?this.removeEdge(n):i++}}},i.prototype.filterNode=function(e,t){for(var i=this.nodes.length,n=0;i>n;)e.call(t,this.nodes[n],n)?n++:(this.removeNode(this.nodes[n]),i--)},i.prototype.filterEdge=function(e,t){for(var i=this.edges.length,n=0;i>n;)e.call(t,this.edges[n],n)?n++:(this.removeEdge(this.edges[n]),i--)},i.prototype.eachNode=function(e,t){for(var i=this.nodes.length,n=0;i>n;n++)this.nodes[n]&&e.call(t,this.nodes[n],n)},i.prot