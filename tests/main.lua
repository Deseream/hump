Timer = require("hump/timer")

function love.load()
   -- test basic functionality
   basic = {x=0, y=0}
   -- test tweening for sub-table
   inner_table = {posn={x=20, y=20}}
   -- test tweening for array-like
   array_like = {40, 40}
   -- test tweening for single getter/setter
   univar_setget = {
      getX = function(self)
	 return self.x
      end,
      getY = function(self)
	 return self.y
      end,
      setX = function(self, x)
	 self.x = x
      end,
      setY = function(self, y)
	 self.y = y
      end,
      x = 60,
      y = 60
   }

   -- test tweening for multi-value getter/setter
   multivar_setget = {
      getP = function(self)
	 return self.x, self.y
      end,
      setP = function(self, x, y)
	 self.x = x
	 self.y = y
      end,
      x = 80,
      y = 80
   }

   -- test tweening for table-best getter/setter
   table_setget = {
      getP = function(self)
	 return self.posn
      end,
      setP = function(self, posn)
	 self.posn.x = posn.x
	 self.posn.y = posn.y
      end,
      posn={x=100, y=100}
   }

   -- test tweening setget for array-like tables
   array_setget = {
      getP = function(self)
	 return self.posn
      end,
      setP = function(self, posn)
	 self.posn=posn
      end,
      posn = {120, 120}
   }
   local pt = 600
   local t = 3
   Timer.tween(t, basic, {x=pt, y=pt})
   Timer.tween(t, inner_table, {posn={x=pt, y=pt}})
   Timer.tween(t, array_like, {pt, pt})
   Timer.tween(t, univar_setget, {getX=pt, getY=pt}, 'linear', nil, {getX=univar_setget.setX,
								     getY=univar_setget.setY})
   -- Timer.tween(t, multivar_setget, {getP={pt, pt}}, nil, {getP=multivar_setget.setP})
   -- Timer.tween(t, table_setget, {getP={x=pt, y=pt}}, nil, {getP=table_setget.setP})
   -- Timer.tween(t, array_setget, {getP={pt, pt}}, nil, {array_setget.getP=setP})
end

function love.draw()
   love.graphics.circle('fill', basic.x, basic.y,10)
   love.graphics.circle('fill', inner_table.posn.x, inner_table.posn.y, 10)
   love.graphics.circle('fill', array_like[1], array_like[2], 10)
   love.graphics.circle('fill', univar_setget:getX(), univar_setget:getY(), 10)
   toshow = {multivar_setget:getP()}
   toshow[#toshow+1] = 10
   love.graphics.circle('fill', unpack(toshow))
   table_toshow = table_setget:getP()
   love.graphics.circle('fill', table_toshow.x, table_toshow.y, 10)
   array_toshow = array_setget:getP()
   array_toshow[#array_toshow+1]=10
   love.graphics.circle('fill', unpack(array_toshow))
end

function love.update(dt)
   Timer.update(dt)
end
