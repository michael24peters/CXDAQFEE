class: ASS_HwTypeGENERICTOPFrontEnd_DU_CLASS/associated
!panel: HwTypeGENERICTOPFrontEnd|HwTypeGENERICTOPFrontEnd_DU.pnl
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START	!visible: 1
        action: RESET	!visible: 1
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE	!visible: 1
        action: RESET	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1
