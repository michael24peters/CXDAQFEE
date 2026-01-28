
object: DAQ is_of_class TOP_DAQ_Domain_v2_CLASS

class: FwChildrenMode_CLASS
!panel: FwChildrenMode.pnl
    state: Complete
    !color: _3DFace
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state IncompleteDead ) move_to IncompleteDead
        when (  ( any_in FWCHILDRENMODE_FWSETSTATES in_state DEAD ) and ( any_in FWCHILDMODE_FWSETSTATES in_state MANUAL )  ) move_to IncompleteDead
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state Incomplete )  move_to Incomplete
        when ( any_in FWCHILDMODE_FWSETSTATES not_in_state {Included,ExcludedPerm,LockedOutPerm} )  move_to Incomplete
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state IncompleteDev )  move_to IncompleteDev
    state: Incomplete
    !color: FwStateAttention2
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state IncompleteDead ) move_to IncompleteDead
        when (  ( any_in FWCHILDRENMODE_FWSETSTATES in_state DEAD ) and ( any_in FWCHILDMODE_FWSETSTATES in_state MANUAL )  ) move_to IncompleteDead
        when (  ( all_in FWCHILDMODE_FWSETSTATES in_state {Included,ExcludedPerm,LockedOutPerm} ) and
       ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state Incomplete )  )  move_to Complete
    state: IncompleteDev
    !color: FwStateAttention1
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state IncompleteDead ) move_to IncompleteDead
        when (  ( any_in FWCHILDRENMODE_FWSETSTATES in_state DEAD ) and ( any_in FWCHILDMODE_FWSETSTATES in_state MANUAL )  ) move_to IncompleteDead
        when (  ( any_in FWCHILDMODE_FWSETSTATES not_in_state {Included,ExcludedPerm,LockedOutPerm} ) or
       ( any_in FWCHILDRENMODE_FWSETSTATES in_state Incomplete )  )  move_to Incomplete
        when (  ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state IncompleteDev )  ) move_to Complete
    state: IncompleteDead
    !color: FwStateAttention3
        when (  (  ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state DEAD ) or ( all_in FWCHILDMODE_FWSETSTATES not_in_state MANUAL )  ) and ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state IncompleteDead )  )  move_to Complete

object: DAQ_FWCNM is_of_class FwChildrenMode_CLASS

class: ASS_FwChildrenMode_CLASS/associated
!panel: FwChildrenMode.pnl
    state: Complete
    !color: _3DFace
    state: Incomplete
    !color: FwStateAttention2
    state: IncompleteDev
    !color: FwStateAttention1
    state: IncompleteDead
    !color: FwStateAttention3

object: FEE::FEE_FWCNM is_of_class ASS_FwChildrenMode_CLASS

object: TELL40::TELL40_FWCNM is_of_class ASS_FwChildrenMode_CLASS

objectset: FWCHILDRENMODE_FWSETSTATES is_of_class VOID

class: FwMode_CLASS
!panel: FwMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
            move_to InLocal
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
            move_to Included
        action: Manual	!visible: 0
            move_to Manual
        action: Ignore	!visible: 0
            move_to Ignored
    state: Included
    !color: FwStateOKPhysics
        action: Exclude(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 0
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 0
            do ExcludeAll(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
    state: InLocal
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: ReleaseAll(string OWNER = "")	!visible: 1
            do ExcludeAll(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
            move_to InLocal
    state: Manual
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
            move_to Included
        action: Take(string OWNER = "")	!visible: 1
            do Include(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to InManual
        action: Exclude(string OWNER = "")	!visible: 0
            do Exclude(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: Ignore	!visible: 0
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 0
            do ExcludeAll(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
    state: InManual
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
        action: ReleaseAll(string OWNER = "")	!visible: 0
            do ExcludeAll(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: SetInLocal	!visible: 0
            move_to InLocal
    state: Ignored
    !color: FwStateOKNotPhysics
        action: Include	!visible: 0
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 0
            do Exclude(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded
        action: Manual	!visible: 0
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) all_in FWCHILDMODE_FWSETACTIONS
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 0
            do ExcludeAll(OWNER=OWNER) all_in FWCHILDMODE_FWSETACTIONS
            move_to Excluded

object: DAQ_FWM is_of_class FwMode_CLASS

class: ASS_FwMode_CLASS/associated
!panel: FwMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Manual	!visible: 0
        action: Ignore	!visible: 0
    state: Included
    !color: FwStateOKPhysics
        action: Exclude(string OWNER = "")	!visible: 0
        action: Manual(string OWNER = "")	!visible: 0
        action: Ignore(string OWNER = "")	!visible: 0
        action: ExcludeAll(string OWNER = "")	!visible: 0
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Free(string OWNER = "")	!visible: 0
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
    state: InLocal
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
        action: ReleaseAll(string OWNER = "")	!visible: 1
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
    state: Manual
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Take(string OWNER = "")	!visible: 1
        action: Exclude(string OWNER = "")	!visible: 0
        action: Ignore	!visible: 0
        action: Free(string OWNER = "")	!visible: 0
        action: ExcludeAll(string OWNER = "")	!visible: 0
    state: InManual
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: ReleaseAll(string OWNER = "")	!visible: 0
        action: SetInLocal	!visible: 0
    state: Ignored
    !color: FwStateOKNotPhysics
        action: Include	!visible: 0
        action: Exclude(string OWNER = "")	!visible: 0
        action: Manual	!visible: 0
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Free(string OWNER = "")	!visible: 0
        action: ExcludeAll(string OWNER = "")	!visible: 0

object: FEE::FEE_FWM is_of_class ASS_FwMode_CLASS

object: TELL40::TELL40_FWM is_of_class ASS_FwMode_CLASS

class: FEE_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( FEE::FEE_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( FEE::FEE_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
                insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) FEE::FEE_FWM
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
            remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( FEE::FEE_FWM in_state Excluded )  do Exclude
        when ( FEE::FEE_FWM in_state Ignored )  move_to IGNORED
        when ( FEE::FEE_FWM in_state Manual )  move_to MANUAL
        when ( FEE::FEE_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( FEE::FEE_FWM not_in_state Included ) then
                if ( FEE::FEE_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) FEE::FEE_FWM
                        remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                        remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                        remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( FEE::FEE_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( FEE::FEE_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
            insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) FEE::FEE_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( FEE::FEE_FWM not_in_state Included ) then
                if ( FEE::FEE_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( FEE::FEE_FWM not_in_state Included ) then
                if ( FEE::FEE_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( FEE::FEE_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) FEE::FEE_FWM
                        remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                        remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                        remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( FEE::FEE_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( FEE::FEE_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( FEE::FEE_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
              insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
              insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
              insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( FEE::FEE_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( FEE::FEE_FWM in_state InManual ) then
                 do SetInLocal FEE::FEE_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) FEE::FEE_FWM
            !move_to Manual
            if ( FEE::FEE_FWM in_state InManual ) then
                 do SetInLocal FEE::FEE_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) FEE::FEE_FWM
              remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
              remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
              remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( FEE::FEE_FWM in_state InManual ) then
                 do SetInLocal FEE::FEE_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( FEE::FEE_FWM in_state InManual ) then
                 do SetInLocal FEE::FEE_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( FEE::FEE_FWM in_state Included )  move_to INCLUDED
        when ( FEE::FEE_FWM in_state Excluded ) move_to EXCLUDED
        when ( FEE::FEE_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
            insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( FEE::FEE_FWM not_in_state Included ) then
                if ( FEE::FEE_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) FEE::FEE_FWM
            insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
            remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) FEE::FEE_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( FEE::FEE_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( FEE::FEE_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) FEE::FEE_FWM
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                    remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) FEE::FEE_FWM
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETSTATES
                remove FEE::FEE from DAQ_DOMAIN_V2_FWSETACTIONS
                remove FEE::FEE_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( FEE::FEE_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
                insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOutPerm	!visible: 0
            move_to LockedOutPerm
    state: ExcludedPerm
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            !    else
            !        move_to Excluded
            !    endif
            !else
            !endif
            !move_to Included
            if ( FEE::FEE_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
                insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
    state: LockedOutPerm
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( FEE::FEE_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) FEE::FEE_FWM
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETSTATES
                insert FEE::FEE in DAQ_DOMAIN_V2_FWSETACTIONS
                insert FEE::FEE_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: FEE_FWM is_of_class FEE_FwChildMode_CLASS

class: TELL40_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TELL40::TELL40_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( TELL40::TELL40_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
                insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
            remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( TELL40::TELL40_FWM in_state Excluded )  do Exclude
        when ( TELL40::TELL40_FWM in_state Ignored )  move_to IGNORED
        when ( TELL40::TELL40_FWM in_state Manual )  move_to MANUAL
        when ( TELL40::TELL40_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state Included ) then
                if ( TELL40::TELL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                        remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                        remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                        remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( TELL40::TELL40_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
            insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) TELL40::TELL40_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( TELL40::TELL40_FWM not_in_state Included ) then
                if ( TELL40::TELL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state Included ) then
                if ( TELL40::TELL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( TELL40::TELL40_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                        remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                        remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                        remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( TELL40::TELL40_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TELL40::TELL40_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( TELL40::TELL40_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
              insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
              insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
              insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( TELL40::TELL40_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( TELL40::TELL40_FWM in_state InManual ) then
                 do SetInLocal TELL40::TELL40_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) TELL40::TELL40_FWM
            !move_to Manual
            if ( TELL40::TELL40_FWM in_state InManual ) then
                 do SetInLocal TELL40::TELL40_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) TELL40::TELL40_FWM
              remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
              remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
              remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( TELL40::TELL40_FWM in_state InManual ) then
                 do SetInLocal TELL40::TELL40_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( TELL40::TELL40_FWM in_state InManual ) then
                 do SetInLocal TELL40::TELL40_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( TELL40::TELL40_FWM in_state Included )  move_to INCLUDED
        when ( TELL40::TELL40_FWM in_state Excluded ) move_to EXCLUDED
        when ( TELL40::TELL40_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
            insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state Included ) then
                if ( TELL40::TELL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) TELL40::TELL40_FWM
            insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
            remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) TELL40::TELL40_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( TELL40::TELL40_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) TELL40::TELL40_FWM
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                    remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) TELL40::TELL40_FWM
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETSTATES
                remove TELL40::TELL40 from DAQ_DOMAIN_V2_FWSETACTIONS
                remove TELL40::TELL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
                insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOutPerm	!visible: 0
            move_to LockedOutPerm
    state: ExcludedPerm
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            !    else
            !        move_to Excluded
            !    endif
            !else
            !endif
            !move_to Included
            if ( TELL40::TELL40_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
                insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
    state: LockedOutPerm
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TELL40::TELL40_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TELL40::TELL40_FWM
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETSTATES
                insert TELL40::TELL40 in DAQ_DOMAIN_V2_FWSETACTIONS
                insert TELL40::TELL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: TELL40_FWM is_of_class TELL40_FwChildMode_CLASS

objectset: FWCHILDMODE_FWSETSTATES is_of_class VOID {FEE_FWM,
	TELL40_FWM }
objectset: FWCHILDMODE_FWSETACTIONS is_of_class VOID {FEE_FWM,
	TELL40_FWM }

object: FEE::FEE is_of_class ASS_DAQ_Domain_v2_CLASS

object: TELL40::TELL40 is_of_class ASS_DAQ_Domain_v2_CLASS

objectset: DAQ_DOMAIN_V2_FWSETSTATES is_of_class VOID
objectset: DAQ_DOMAIN_V2_FWSETACTIONS is_of_class VOID


objectset: FWCHILDREN_FWSETACTIONS union {DAQ_DOMAIN_V2_FWSETACTIONS } is_of_class VOID
objectset: FWCHILDREN_FWSETSTATES union {DAQ_DOMAIN_V2_FWSETSTATES } is_of_class VOID

