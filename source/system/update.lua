[[--
    Nested Co-routines By Jericho
]]--

if coroutine.status(MainCoroutine) == "dead" then
  MainCoroutine = coroutine.create(runCoroutines)
end
if coroutine.status(MainCoroutine) == "suspended" then
  assert(coroutine.resume(MainCoroutine))
end