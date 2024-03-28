import React, { useCallback } from 'react';
import ReactFlow, {
  addEdge,
  ConnectionLineType,
  Panel,
  useNodesState,
  useEdgesState,
} from 'reactflow';
import dagre from 'dagre';
import { useHistory } from "react-router-dom";
 
// we have to import the React Flow styles for it to work
import 'reactflow/dist/style.css';

const dagreGraph = new dagre.graphlib.Graph();
dagreGraph.setDefaultEdgeLabel(() => ({}));

const nodeWidth = 150;
const nodeHeight = 36;

const getLayoutedElements = (nodes, edges, direction = 'LR') => {
  const isHorizontal = direction === 'LR';
  dagreGraph.setGraph({ rankdir: direction });

  nodes.forEach((node) => {
    dagreGraph.setNode(node.id, { width: nodeWidth, height: nodeHeight });
  });

  edges.forEach((edge) => {
    dagreGraph.setEdge(edge.source, edge.target);
  });

  dagre.layout(dagreGraph);

  nodes.forEach((node) => {
    const nodeWithPosition = dagreGraph.node(node.id);
    node.targetPosition = isHorizontal ? 'left' : 'top';
    node.sourcePosition = isHorizontal ? 'right' : 'bottom';

    // We are shifting the dagre node position (anchor=center center) to the top left
    // so it matches the React Flow node anchor point (top left).
    node.position = {
      x: nodeWithPosition.x - nodeWidth / 2,
      y: nodeWithPosition.y - nodeHeight / 2,
    };

    return node;
  });

  return { nodes, edges };
};

const Mindmap = (nodesTree) => {
  const initialNodes = []
  const initialEdges = []
  var id = 0;
  const fillNodes = (nodeTree, parentID)=>{
    console.log(nodeTree);
    
    const nodeId = 'n' + (id++);
    const node = { id: nodeId, data: { label: nodeTree.label, href: nodeTree.href } };
    initialNodes.push(node);
    if(parentID){
      initialEdges.push({ id: 'e' + parentID + nodeId, source: parentID, target: nodeId });
    } else {
      node.type = 'input'
    }
    if(nodeTree.child){
      nodeTree.child.forEach(childNode=>{
        fillNodes(childNode, nodeId);
      })
    } else{
      node.type = 'output'
    }
  }
  
  fillNodes(nodesTree.nodesTree, undefined);

  const { nodes: layoutedNodes, edges: layoutedEdges } = getLayoutedElements(
    initialNodes,
    initialEdges
  );
  
  const [nodes, setNodes, onNodesChange] = useNodesState(layoutedNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(layoutedEdges);

  const onConnect = useCallback(
    (params) =>
      setEdges((eds) =>
        addEdge({ ...params, type: ConnectionLineType.SmoothStep, animated: true }, eds)
      ),
    []
  );

  const history = useHistory();
  const onNodeClick = (event, node) => history.push(node.data.href);

  return (
    <div style={{ width: '100%', height: '1000px' }}>
    <ReactFlow
      nodes={nodes}
      edges={edges}
      onNodesChange={onNodesChange}
      onEdgesChange={onEdgesChange}
      onConnect={onConnect}
      connectionLineType={ConnectionLineType.SmoothStep}
      //fitView
      onNodeClick={onNodeClick}
      // zoomOnScroll={false}
      // panOnDrag={true}
      nodesDraggable={false}
      />
    </div>
  );
};

const Node = (label, href, child) =>{
    return {label: label, href: href, child: child};
}

export { Mindmap, Node };
