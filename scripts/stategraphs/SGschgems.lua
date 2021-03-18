require("stategraphs/commonstates")

local actionhandlers =
{    

}

local events = 
{
    CommonHandlers.OnLocomote(true, false),

}

local states =
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, pushanim)    
            inst.Physics:Stop()
			inst.AnimState:PushAnimation("proximity_loop", true)
        end,
    },

    State{
        name = "run_start",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst)
			inst.components.locomotor:RunForward()
			inst.AnimState:PushAnimation("proximity_loop", true)
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
        
        timeline=
        {        
            TimeEvent(4*FRAMES, function(inst)
            end),
        },        
        
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 
            inst.components.locomotor:RunForward()
			inst.AnimState:PushAnimation("proximity_loop", true)
        end,
        
        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        timeline=
        {
            TimeEvent(7*FRAMES, function(inst)
            end),
            TimeEvent(15*FRAMES, function(inst)
            end),
        },
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
    },
    
    State{
    
        name = "run_stop",
        tags = {"canrotate", "idle"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
			inst.AnimState:PushAnimation("proximity_loop", true)
        end,
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
        
    },
	
    State
    {
        name = "open",
        tags = { "busy", "open" },
        
        onenter = function(inst) 
            inst.Physics:Stop()
			inst.AnimState:PushAnimation("proximity_loop", true)
	    end,
        
        onexit = function(inst)

        end,
        
        ontimeout = function(inst) 

		end,
    },

}

return StateGraph("sch_gems", states, events, "idle", actionhandlers)