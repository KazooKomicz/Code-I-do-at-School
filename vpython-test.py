from vpython import*
import math, random

scene = canvas(title='VPython Demo', width = 1200, height = 800, background = color.cyan, ambient = vector(random.uniform(0,1), random.uniform(0,1), random.uniform(0,1)))
player = sphere(pos = vector(0,0.8,0), radius = 0.5, color = vector(random.uniform(0,1), random.uniform(0,1), random.uniform(0,1)))
ground = box(pos = vector(0,0,0), length = 100, width = 100, height = 0.1, texture = textures.stucco)
dy = 10
dv = 0.3
dt = 0.1
v = vector(0,0,0)
jump = False

while True:
    rate(30)
    k = keysdown()

    if 'a' in k: v.x -= dv
    if 'd' in k: v.x += dv
    if 's' in k: v.z += dv
    if 'w' in k: v.z -= dv
    if ' ' in k: 
        if(v.y == 0):
                v.y = dy

    if not bool(k):
        v = (v - 0.1 * v.norm()) if v.mag > 0.1 else vector(0,0,0)
        if(player.pos.y > 0.8 or v.y == 10):
            jump = True
            v.y = dy
            dy -= 0.7
        else: 
             v.y = 0
             dy = 10
             jump = False
    player.pos += v*dt
    if(player.pos.y < 0.8): player.pos.y = 0.8
    s = "V = <{:.1f}, {:.1f}, {:.1f}>; Key Found: {}; Jump: {}".format(v.x, v.y, v.z, k, jump)
    scene.caption = s
    scene.center = player.pos
    scene.range = 10 * math.tan(0.5 * scene.fov)