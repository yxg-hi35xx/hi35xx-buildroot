#!/usr/bin/env wsapi.fcgi

module(..., package.seeall)

local json = require "json"
local wsapi = require "wsapi"
wsapi.request = require "wsapi.request"
local sdbus = require 'simpledbus'
local bus = sdbus.SystemBus()
local vs0 = bus:auto_proxy('ipcam.Media', '/ipcam/Media/VideoSource0')
local vs0img = vs0['ipcam.Media.VideoSource.Imaging']

function run(wsapi_env)
  local headers = { ["Content-type"] = "application/json" }
  local imaging = 'ipcam.Media.VideoSource.Imaging'
  local req = wsapi.request.new(wsapi_env)
  local resp = {}

  if req.method == "POST" then
    local ri = json.decode(req.POST.post_data)
    if ri.angle ~= nil then
      vs0img.Rotation = ri.angle
    end
    resp.status = "OK"
  elseif req.method == "GET" then
    resp.angle = vs0img.Rotation
  else
    resp.status = "FAIL"
    resp.message = "Unsupported method"
  end

  local function html_text()
    coroutine.yield(json.encode(resp))
  end

  return 200, headers, coroutine.wrap(html_text)
end
