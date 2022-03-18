from ._binarystream import _BinaryStream
from collections import OrderedDict
from struct import *

class WORLDGRAPH:
    def __init__(self, stream):
        self._stream = stream
        self._vertices = OrderedDict()
        self._edges = OrderedDict()
        self._outgouingEdges = {}
        self._vertexUid = 0


    def read(self):
        raw = _BinaryStream(self._stream)

        edgeCount = raw.read_int32()

        for i in range(edgeCount):
            _from = self.addVertex(raw.read_int64(), raw.read_int32())
            _dest = self.addVertex(raw.read_int64(), raw.read_int32())
            _edge = self.addEdge(_from, _dest)
            transitionCount = raw.read_int32()
            for i in range(transitionCount):
                dir = raw.read_char()
                type = raw.read_char()
                skill = raw.read_int32()
                lenght = raw.read_int32()
                criterion = ""
                if lenght > 0:
                    bytes = raw.read_bytes(lenght)
                    criterion = unpack(">" + str(lenght) + 's', bytes)[0].decode('utf8')

                transitionMapId = raw.read_int64()
                cell = raw.read_int32()
                id = raw.read_int64()
                _edge.addTransition(dir, type, skill, criterion, transitionMapId, cell, id)

        return self

    def readString(self, raw):
        lenght = raw.read_int32()
        return raw._unpack(str(lenght) + 's', lenght)

    def addVertex(self, mapId, zone):
        vertex = None
        if not mapId in self._vertices:
            self._vertices[mapId] = OrderedDict()
        else:
            vertex = self._vertices[mapId][zone]

        if vertex is None:
            self._vertexUid = self._vertexUid + 1
            vertex = Vertex(mapId, zone, self._vertexUid)
            self._vertices[mapId][zone] = vertex.newVertex()

        return vertex

    def addEdge(self, _from, _dest):
        edge = self.getEdge(_from, _dest)

        if edge is not None:
            return edge

        if not self.doesVertexExist(_from) or not self.doesVertexExist(_dest):
            return None

        edge = Edge(_from, _dest).newEdge()

        if not _from._uid in self._edges:
            self._edges[_from._uid] = OrderedDict()

        self._edges[_from._uid][_dest._uid] = edge

        if not _from._uid in self._outgouingEdges:
            self._outgouingEdges[_from._uid] = edge

        self._outgouingEdges[_from._uid] = edge
        return edge

    def getEdge(self, _from, _dest):
        if _from._uid in self._edges:
            return self._edges[str(_from._uid)][str(_dest._uid)]
        else:
            return None

    def doesVertexExist(self, vertex):
        if vertex._mapId in self._vertices:
            if vertex._zoneId in self._vertices[vertex._mapId]:    
                return True
        
        return False

class Vertex:
    def __init__(self, mapId, zoneId, vertexUid):
        self._mapId = mapId
        self._zoneId = zoneId
        self._uid = vertexUid

    def newVertex(self):
        return self
    
class Edge:
    def __init__(self, _from, _dest):
        self._from = _from
        self._to = _dest
        self._transitions = []

    def newEdge(self):
        return self

    def addTransition(self, dir, type, skill, criterion, transitionMapId, cell, id):
        self._transitions.append(Transition(dir, type, skill, criterion, transitionMapId, cell, id).newTransition())

class Transition:
    def __init__(self, dir, type, skill, criterion, transitionMapId, cell, id):
        self._dir = dir
        self._type = type
        self._skill = skill
        self._criterion = criterion
        self._transitionMapId = transitionMapId
        self._cell = cell
        self._id = id

    def newTransition(self):
        return self