class: TOP_STFCType_CLASS
!panel: STFCType.pnl
    state: NOT_READY
    !color: FwStateAttention1
        when ( any_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state {READY,RUNNING} ) move_to READY
        when ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state RUNNING )  move_to RUNNING
        action: CONFIGURE(string RUN_TYPE = "PHYSICS", string RUN_INFO_DP = "")	!visible: 1
            do CONFIGURE(RUN_TYPE=RUN_TYPE,RUN_INFO_DP=RUN_INFO_DP) all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state READY ) then
                move_to NOT_READY
            endif
            move_to READY
        action: RESET	!visible: 1
            do RESET all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: READY
    !color: FwStateOKNotPhysics
        when ( any_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( any_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state NOT_READY ) move_to NOT_READY
        when ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state RUNNING )  move_to RUNNING
        action: START_RUN(int N_TRIGGERS = 0, string AUTO_STEP_FILE = "")	!visible: 0
            do START_RUN(N_TRIGGERS=N_TRIGGERS, AUTO_STEP_FILE=AUTO_STEP_FILE) all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state RUNNING ) then
                move_to READY
            endif
            move_to RUNNING
        action: START(int N_TRIGGERS = 0, string AUTO_STEP_FILE = "")	!visible: 1
            do START(N_TRIGGERS=N_TRIGGERS, AUTO_STEP_FILE=AUTO_STEP_FILE) all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state RUNNING ) then
                move_to READY
            endif
            move_to RUNNING
        action: RESET	!visible: 1
            do RESET all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: RUNNING
    !color: FwStateOKPhysics
        when ( any_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( any_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state NOT_READY ) move_to NOT_READY
        when ( any_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES in_state READY ) move_to READY
        action: STOP_RUN	!visible: 0
            do STOP_RUN all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: STOP	!visible: 1
            do STOP all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: RESET	!visible: 1
            do RESET all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: ERROR
    !color: FwStateAttention3
        when ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state ERROR ) move_to NOT_READY
        action: RECOVER	!visible: 1
            do RECOVER all_in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            if ( all_in HWTYPEGBTQ_SOL40_DU_FWSETSTATES not_in_state NOT_READY ) then
            	move_to ERROR
            endif
            move_to NOT_READY

object: CODEXB_SOL40 is_of_class TOP_STFCType_CLASS

class: FwChildrenMode_CLASS
!panel: FwChildrenMode.pnl
    state: Complete
    !color: _3DFace
        when ( any_in FWDEVMODE_FWSETSTATES in_state DISABLED )  move_to IncompleteDev
    state: Incomplete
    !color: FwStateAttention2
    state: IncompleteDev
    !color: FwStateAttention1
        when (  ( all_in FWDEVMODE_FWSETSTATES not_in_state DISABLED )  ) move_to Complete
    state: IncompleteDead
    !color: FwStateAttention3

object: CODEXB_SOL40_FWCNM is_of_class FwChildrenMode_CLASS

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

object: CODEXB_SOL40_FWM is_of_class FwMode_CLASS

class: FwDevMode_FwDevMode_CLASS
    state: READY
        action: Disable(Device)
            remove &VAL_OF_Device from FWDEVMODE_FWSETSTATES
            remove &VAL_OF_Device from FWDEVMODE_FWSETACTIONS
            move_to READY
        action: Enable(Device)
            insert &VAL_OF_Device in FWDEVMODE_FWSETSTATES
            insert &VAL_OF_Device in FWDEVMODE_FWSETACTIONS
            move_to READY

object: FwDevMode_FWDM is_of_class FwDevMode_FwDevMode_CLASS


class: FwDevMode_CLASS/associated
!panel: FwDevMode.pnl
    state: ENABLED
    !color: FwStateOKPhysics
    state: DISABLED
    !color: FwStateAttention1

object: CODEXB_SOL40_FWDM is_of_class FwDevMode_CLASS

objectset: FWDEVMODE_FWSETSTATES is_of_class VOID {CODEXB_SOL40_FWDM }
objectset: FWDEVMODE_FWSETACTIONS is_of_class VOID {CODEXB_SOL40_FWDM }

class: HwTypeGBTQ_SOL40_DU_FwDevMode_CLASS
    state: READY
        action: Disable(Device)
            remove &VAL_OF_Device from HWTYPEGBTQ_SOL40_DU_FWSETSTATES
            remove &VAL_OF_Device from HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            move_to READY
        action: Enable(Device)
            insert &VAL_OF_Device in HWTYPEGBTQ_SOL40_DU_FWSETSTATES
            insert &VAL_OF_Device in HWTYPEGBTQ_SOL40_DU_FWSETACTIONS
            move_to READY

object: HwTypeGBTQ_SOL40_DU_FWDM is_of_class HwTypeGBTQ_SOL40_DU_FwDevMode_CLASS


class: HwTypeGBTQ_SOL40_DU_CLASS/associated
!panel: HwTypeGBTQ_SOL40|HwTypeGBTQ_SOL40_DU.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(string RUN_TYPE = "PHYSICS", string RUN_INFO_DP = "")	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(string AUTO_STEP_FILE = "")	!visible: 0
        action: START(string AUTO_STEP_FILE = "")	!visible: 1
        action: RESET	!visible: 1
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: RESET	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1

object: cxsol01:Link00 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link01 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link02 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link03 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link04 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link05 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link06 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link07 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link08 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link09 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link10 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link11 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link12 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link13 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link14 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link15 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link16 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link17 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link18 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link19 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link20 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link21 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link22 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link23 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link24 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link25 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link26 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link27 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link28 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link29 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link30 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link31 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link32 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link33 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link34 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link35 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link36 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link37 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link38 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link39 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link40 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link41 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link42 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link43 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link44 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link45 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link46 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

object: cxsol01:Link47 is_of_class HwTypeGBTQ_SOL40_DU_CLASS

objectset: HWTYPEGBTQ_SOL40_DU_FWSETSTATES is_of_class VOID {cxsol01:Link00,
	cxsol01:Link01,
	cxsol01:Link02,
	cxsol01:Link03,
	cxsol01:Link04,
	cxsol01:Link05,
	cxsol01:Link06,
	cxsol01:Link07,
	cxsol01:Link08,
	cxsol01:Link09,
	cxsol01:Link10,
	cxsol01:Link11,
	cxsol01:Link12,
	cxsol01:Link13,
	cxsol01:Link14,
	cxsol01:Link15,
	cxsol01:Link16,
	cxsol01:Link17,
	cxsol01:Link18,
	cxsol01:Link19,
	cxsol01:Link20,
	cxsol01:Link21,
	cxsol01:Link22,
	cxsol01:Link23,
	cxsol01:Link24,
	cxsol01:Link25,
	cxsol01:Link26,
	cxsol01:Link27,
	cxsol01:Link28,
	cxsol01:Link29,
	cxsol01:Link30,
	cxsol01:Link31,
	cxsol01:Link32,
	cxsol01:Link33,
	cxsol01:Link34,
	cxsol01:Link35,
	cxsol01:Link36,
	cxsol01:Link37,
	cxsol01:Link38,
	cxsol01:Link39,
	cxsol01:Link40,
	cxsol01:Link41,
	cxsol01:Link42,
	cxsol01:Link43,
	cxsol01:Link44,
	cxsol01:Link45,
	cxsol01:Link46,
	cxsol01:Link47 }
objectset: HWTYPEGBTQ_SOL40_DU_FWSETACTIONS is_of_class VOID {cxsol01:Link00,
	cxsol01:Link01,
	cxsol01:Link02,
	cxsol01:Link03,
	cxsol01:Link04,
	cxsol01:Link05,
	cxsol01:Link06,
	cxsol01:Link07,
	cxsol01:Link08,
	cxsol01:Link09,
	cxsol01:Link10,
	cxsol01:Link11,
	cxsol01:Link12,
	cxsol01:Link13,
	cxsol01:Link14,
	cxsol01:Link15,
	cxsol01:Link16,
	cxsol01:Link17,
	cxsol01:Link18,
	cxsol01:Link19,
	cxsol01:Link20,
	cxsol01:Link21,
	cxsol01:Link22,
	cxsol01:Link23,
	cxsol01:Link24,
	cxsol01:Link25,
	cxsol01:Link26,
	cxsol01:Link27,
	cxsol01:Link28,
	cxsol01:Link29,
	cxsol01:Link30,
	cxsol01:Link31,
	cxsol01:Link32,
	cxsol01:Link33,
	cxsol01:Link34,
	cxsol01:Link35,
	cxsol01:Link36,
	cxsol01:Link37,
	cxsol01:Link38,
	cxsol01:Link39,
	cxsol01:Link40,
	cxsol01:Link41,
	cxsol01:Link42,
	cxsol01:Link43,
	cxsol01:Link44,
	cxsol01:Link45,
	cxsol01:Link46,
	cxsol01:Link47 }


objectset: FWCHILDREN_FWSETACTIONS union {HWTYPEGBTQ_SOL40_DU_FWSETACTIONS } is_of_class VOID
objectset: FWCHILDREN_FWSETSTATES union {HWTYPEGBTQ_SOL40_DU_FWSETSTATES } is_of_class VOID

