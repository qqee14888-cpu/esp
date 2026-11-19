-- esp by deletez
local P=game:GetService("Players") local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService") local Cam=workspace.CurrentCamera
local LP=P.LocalPlayer
local C={Purple=Color3.fromRGB(180,0,255),Bg=Color3.fromRGB(20,20,20),Text=Color3.fromRGB(220,220,220),Dim=Color3.fromRGB(140,140,140)}
local S={Box=true,Skel=true,Chams=true,Open=true,A=1}
local function D(c) local ok,o=pcall(Drawing.new,c) return ok and o or nil end
local cache={} local chams={}
local function mk(p) if p==LP or cache[p] then return end
  local b=D("Square") if b then b.Color=C.Purple b.Thickness=1 b.Filled=false b.Transparency=1 end
  local sk={} for i=1,20 do local l=D("Line") if l then l.Color=C.Purple l.Thickness=1 l.Transparency=1 sk[i]=l end end
  cache[p]={b=b,sk=sk} end
local function del(p) local d=cache[p] if not d then return end
  if d.b then d.b:Remove() end for _,l in ipairs(d.sk) do l:Remove() end cache[p]=nil end
local R6={{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}
local R15={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"UpperTorso","RightUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"RightUpperArm","RightLowerArm"},{"LeftLowerArm","LeftHand"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LowerTorso","RightUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"RightUpperLeg","RightLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"RightLowerLeg","RightFoot"}}
local function part(c,n) local p=c:FindFirstChild(n) return p and p:IsA("BasePart") and p.Position or nil end
local function w2s(v) local s,on=Cam:WorldToViewportPoint(v) return on and Vector2.new(s.X,s.Y) or nil end
local function clrC() for _,h in pairs(chams) do if h.Parent then h:Destroy() end end chams={} end
local function setC(c) if chams[c] and chams[c].Parent then return end
  local h=Instance.new("Highlight") h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
  h.FillColor=C.Purple h.FillTransparency=0.55 h.OutlineColor=C.Purple h.OutlineTransparency=0 h.Parent=c chams[c]=h end
local hud={}
local function mkT(t,y,s,col) local o=D("Text") if not o then return nil end
  o.Text=t o.Size=s or 12 o.Color=col or C.Text o.Position=Vector2.new(32,y) return o end
local function buildHUD()
  hud.bg=D("Square") if hud.bg then hud.bg.Filled=true hud.bg.Color=C.Bg hud.bg.Transparency=0.15
    hud.bg.Size=Vector2.new(240,180) hud.bg.Position=Vector2.new(20,20) end
  hud.title=mkT("ESP BY DELETEZ",28,16,C.Text) hud.hint=mkT("[HOME] hide/show",48,11,C.Dim)
  hud.status=mkT("chams: on",66,12,C.Purple) hud.box=mkT("[1] Box",88,12)
  hud.skel=mkT("[2] Skeleton",106,12) hud.chams=mkT("[3] Chams",124,12)
  hud.foot=mkT("esp by deletez",158,11,C.Dim) end
local function hA(a) for k,o in pairs(hud) do if o and k~="bg" then o.Transparency=a end end
  if hud.bg then hud.bg.Transparency=a*0.85 end end
local function rr(o,on) if o then o.Color=on and C.Text or C.Dim end end
UIS.InputBegan:Connect(function(i,gp) if gp then return end
  if i.KeyCode==Enum.KeyCode.One then S.Box=not S.Box rr(hud.box,S.Box)
  elseif i.KeyCode==Enum.KeyCode.Two then S.Skel=not S.Skel rr(hud.skel,S.Skel)
  elseif i.KeyCode==Enum.KeyCode.Three then S.Chams=not S.Chams rr(hud.chams,S.Chams)
    if not S.Chams then clrC() end
    if hud.status then hud.status.Text="chams: "..(S.Chams and "on" or "off") end
  elseif i.KeyCode==Enum.KeyCode.Home then S.Open=not S.Open end end)
local function draw(p,d) local c=p.Character local hu=c and c:FindFirstChildOfClass("Humanoid")
  if not c or not hu or hu.Health<=0 then if d.b then d.b.Visible=false end
    for _,l in ipairs(d.sk) do l.Visible=false end return end
  local hd=part(c,"Head") local hr=c:FindFirstChild("HumanoidRootPart") if not hd or not hr then return end
  if d.b then local t,b=w2s(hd+Vector3.new(0,0.5,0)),w2s(hr.Position-Vector3.new(0,3,0))
    if S.Box and t and b then local h=math.abs(b.Y-t.Y) local w=h*0.55
      d.b.Size=Vector2.new(w,h) d.b.Position=Vector2.new(t.X-w/2,t.Y) d.b.Visible=true
    else d.b.Visible=false end end
  local ls=(hu.RigType==Enum.HumanoidRigType.R15) and R15 or R6 local ix=1
  for _,pr in ipairs(ls) do local a,b=part(c,pr[1]),part(c,pr[2])
    if a and b and d.sk[ix] then local sa,sb=w2s(a),w2s(b) local l=d.sk[ix]
      if S.Skel and sa and sb then l.From=sa l.To=sb l.Visible=true else l.Visible=false end
      ix=ix+1 end end
  for i=ix,#d.sk do d.sk[i].Visible=false end end
local function uC() if not S.Chams then clrC() return end
  local sn,n={},0
  for _,p in ipairs(P:GetPlayers()) do if p~=LP and p.Character and n<28 then
    local hr=p.Character:FindFirstChild("HumanoidRootPart")
    if hr then local _,on=Cam:WorldToViewportPoint(hr.Position)
      local ds=(Cam.CFrame.Position-hr.Position).Magnitude
      if on or ds<100 then setC(p.Character) sn[p.Character]=true n=n+1 end end end end
  for c,h in pairs(chams) do if not sn[c] or not h.Parent then
    if h.Parent then h:Destroy() end chams[c]=nil end end end
buildHUD()
for _,p in ipairs(P:GetPlayers()) do mk(p) end
P.PlayerAdded:Connect(mk) P.PlayerRemoving:Connect(del)
local ac=0
RS.RenderStepped:Connect(function(dt) local tg=S.Open and 1 or 0
  S.A=S.A+(tg-S.A)*math.min(dt*8,1) if math.abs(S.A-tg)<0.01 then S.A=tg end hA(S.A)
  ac=ac+dt if ac>=1/30 then ac=0
    for p,d in pairs(cache) do if p.Parent and p.Character then draw(p,d) else del(p) end end
    uC() end end)
