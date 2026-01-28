class: TOP_SODINType_CLASS
!panel: SODINType.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(int STEP_NR = -1, string RUN_TYPE = "PHYSICS")	!visible: 1
            move_to READY
        action: RESET	!visible: 1
            move_to NOT_READY
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0)	!visible: 0
            move_to ACTIVE
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, int STEP_PERIOD = 0)	!visible: 1
            move_to ACTIVE
        action: RESET	!visible: 1
            move_to NOT_READY
    state: ACTIVE
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
            move_to READY
        action: STOP	!visible: 1
            move_to READY
        action: START_TRIGGER(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, int RUN_NUMBER = 0)	!visible: 1
            move_to RUNNING
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, int STEP_PERIOD = 0)	!visible: 0
            move_to ACTIVE
        action: START_RUN	!visible: 0
            move_to RUNNING
        action: START_SCAN	!visible: 0
            move_to RUNNING
        action: STOP_SCAN	!visible: 0
            move_to READY
        action: RESET	!visible: 1
            move_to NOT_READY
    state: PAUSED
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
            move_to READY
        action: STOP	!visible: 1
            move_to READY
        action: CONTINUE(int N_TRIGGERS = 0, float STEP_PERIOD = 0.0)	!visible: 1
            move_to RUNNING
        action: STOP_TRIGGER	!visible: 1
            move_to ACTIVE
        action: RESET	!visible: 1
            move_to NOT_READY
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
            move_to READY
        action: STOP	!visible: 1
            move_to READY
        action: PAUSE	!visible: 1
            move_to PAUSED
        action: STOP_TRIGGER	!visible: 1
            move_to ACTIVE
        action: STOP_SCAN	!visible: 1
            move_to READY
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1
            move_to NOT_READY

object: SODIN is_of_class TOP_SODINType_CLASS

class: FwChildrenMode_CLASS
!panel: FwChildrenMode.pnl
    state: Complete
    !color: _3DFace
    state: Incomplete
    !color: FwStateAttention2
    state: IncompleteDev
    !color: FwStateAttention1
    state: IncompleteDead
    !color: FwStateAttention3

object: SODIN_FWCNM is_of_class FwChildrenMode_CLASS

class: FwMode_CLASS
!panel: FwMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            move_to InLocal
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            move_to Included
        action: Manual	!visible: 0
            move_to Manual
        action: Ignore	!visible: 0
            move_to Ignored
    state: Included
    !color: FwStateOKPhysics
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 0
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
    state: InLocal
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
            move_to Excluded
        action: ReleaseAll(string OWNER = "")	!visible: 1
            move_to Excluded
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            move_to InLocal
    state: Manual
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            move_to Included
        action: Take(string OWNER = "")	!visible: 1
            move_to InManual
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Ignore	!visible: 0
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 0
            move_to Excluded
    state: InManual
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: ReleaseAll(string OWNER = "")	!visible: 0
            move_to Excluded
        action: SetInLocal	!visible: 0
            move_to InLocal
    state: Ignored
    !color: FwStateOKNotPhysics
        action: Include	!visible: 0
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Manual	!visible: 0
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Free(string OWNER = "")	!visible: 0
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 0
            move_to Excluded

object: SODIN_FWM is_of_class FwMode_CLASS


objectset: FWCHILDREN_FWSETACTIONS is_of_class VOID
objectset: FWCHILDREN_FWSETSTATES is_of_class VOID

