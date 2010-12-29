--    LOS - Lua Object System
--    Copyright (C) 2009  Idelmar Mader

--    This file is part of LOS - Lua Object System.

--    LOS - Lua Object System is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Lesser General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.

--    LOS - Lua Object System is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU Lesser General Public License for more details.

--    You should have received a copy of the GNU Lesser General Public License
--    along with LOS - Lua Object System.  If not, see <http://www.gnu.org/licenses/>.

--- LOS - Lua Object System
-- @release A simple Ruby like object system for Lua.
module('LOS', package.seeall)

---
-- @class table
-- @name class
-- @field my The reference to your class.
-- @field this The reference to your class.

local _G = _G
local type = type
local setmetatable = setmetatable
local getmetatable = getmetatable
local next = next
local loaded = package.loaded
local seeall = package.seeall
local importStack = {}
local push = table.insert
local pop = table.remove

--- Store a directory path.
-- @param path The path used by the <a href="#">import</a> function.
-- @usage <h3><a href="#">from</a> 'org.helper' import 'Stack' 'HTML'</h3>
function _G.from(path)
  push(importStack, path)
end

--- Load a file from the last directory path stored by <a href="#">from</a> function.
-- @param file The file name to be loaded.
-- @usage <h3>from 'org.packages' <a href="#">import</a> 'PDF' 'YAML'</h3>
function _G.import(file)
  local path = pop(importStack)
  local function loader(file)
    require(path..'.'..file)
    return loader
  end
  loader(file)
  return loader
end

--- Override the global function <a href="#"><code>type</code></a> and add class handling support.
-- @usage <h3><a href="#">type(</a>Object:new()<a href="#">)</a></h3>
-- @return The type of object in a string.
-- @param object The object in question.
function _G.type(object)
  if type(object) == 'table' and object.__class then
    return object.__class
  end
  return type(object)
end

--- Clone a object or table (Yes, It support cycles).
-- @usage <h3><a href="#">clone(</a>_G<a href="#">)</a></h3>
-- @param object The object or table to be cloned.
-- @return the clone of object or table.
function _G.clone(object, buffer)
  local buffer = buffer or {}
  local copy = {}
  buffer[object] = object
  for key,value in next,object,nil do
    if type(value) == "table" and not buffer[value] then
      copy[key] = clone(value, buffer)
    else
      copy[key] = value
    end
  end
  setmetatable(copy, getmetatable(object))
  return copy
end

local Object = setmetatable({ __class = 'Object' }, { __index = _G })
Object.my = Object
Object.this = Object
Object.__index = Object
Object.clone = _G.clone

function Object.initialize()
end

function Object:__call(me, ...)
  self.self = me
  self[self.__class](...)
end

function Object:instanceOf(classname)
  local super = self
  while super do
    if super.__class == classname then
      return true
    end
    super = super.super
  end
  return false
end

function Object:new(...)
  local __class = self.__class
  local object = setmetatable({ __class = __class }, self)
  local super = self.super
  while super do
    super.self = object
    if super.initialize then
      super.initialize()
    end
    super.self = nil
    super = super.super
  end
  self.self = object
  if self.initialize then
    self.initialize()
  end
  if self[__class] then
    self[__class](...)
  end
  self.self = nil
  return object
end

--- Create a class.
-- @param name The name of class.
-- @usage <h3><a href="#">class</a> 'Stack'</h3>
function _G.class(name)
  local class = setmetatable(_G[name] or loaded[name] or {}, Object)
  class.__class = name
  class.my = class
  class.this = class
  class.__index = class
  class.super = Object

  --- Overload a existent method.
  -- 
  -- @param nameOfMethod The name of existing method.
  -- @usage <h3><a href="#">overload</a>('add', function (param1, param2) print(param1, param2) end, 2)</h3>
  -- @param method The callback function.
  -- @param numberOfParameters The number of parameter used to call "method" callback.
  function _G.overload(nameOfMethod, method, numberOfParameters)
    local function overloadeds(virtualMethodTable, _, ...)
      virtualMethodTable[arg.n](...)
    end
    class[nameOfMethod] = class[nameOfMethod] or {}
    class[nameOfMethod][numberOfParameters] = method
    setmetatable(class[nameOfMethod], { __call = overloadeds })
  end
  
  --- Make inheritance in a class.
  -- @usage <h3>class 'Stack' <a href="#">extends</a> 'Queue'</h3>
  -- @param parentClass The name of parent class.
  function _G.extends(parentClass)
    local parent = _G[parentClass]
    setmetatable(class, parent)
    class.super = parent
    class.super.__call = class.__call
    class.initialize = function() end
  end

  --- Emulates virtual inheritance.
  -- @usage <h3>class 'Stack' extends 'Queue' <a href="#">mixin</a> 'Serializable'</h3>
  -- @param toMixIn The name of class.
  function _G.mixin(toMixIn)
    local mixinTable = _G[toMixIn]
    for key,value in next,mixinTable,nil do
      if type(value) == 'table' and not class[key] then
        class[key] = clone(value)
      elseif not class[key] then
        class[key] = value
      end
    end
  end
  
  _G[name] = class
  setfenv(2, class)
end

_G.Object = Object
