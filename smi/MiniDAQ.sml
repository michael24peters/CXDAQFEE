class: DAQ_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( DAQ::DAQ_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( DAQ::DAQ_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
                insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
            remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( DAQ::DAQ_FWM in_state Excluded )  do Exclude
        when ( DAQ::DAQ_FWM in_state Ignored )  move_to IGNORED
        when ( DAQ::DAQ_FWM in_state Manual )  move_to MANUAL
        when ( DAQ::DAQ_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( DAQ::DAQ_FWM not_in_state Included ) then
                if ( DAQ::DAQ_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                        remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                        remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                        remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( DAQ::DAQ_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( DAQ::DAQ_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
            insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) DAQ::DAQ_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( DAQ::DAQ_FWM not_in_state Included ) then
                if ( DAQ::DAQ_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( DAQ::DAQ_FWM not_in_state Included ) then
                if ( DAQ::DAQ_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( DAQ::DAQ_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                        remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                        remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                        remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( DAQ::DAQ_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( DAQ::DAQ_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( DAQ::DAQ_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
              insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
              insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
              insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( DAQ::DAQ_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( DAQ::DAQ_FWM in_state InManual ) then
                 do SetInLocal DAQ::DAQ_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) DAQ::DAQ_FWM
            !move_to Manual
            if ( DAQ::DAQ_FWM in_state InManual ) then
                 do SetInLocal DAQ::DAQ_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) DAQ::DAQ_FWM
              remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
              remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
              remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( DAQ::DAQ_FWM in_state InManual ) then
                 do SetInLocal DAQ::DAQ_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( DAQ::DAQ_FWM in_state InManual ) then
                 do SetInLocal DAQ::DAQ_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( DAQ::DAQ_FWM in_state Included )  move_to INCLUDED
        when ( DAQ::DAQ_FWM in_state Excluded ) move_to EXCLUDED
        when ( DAQ::DAQ_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
            insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( DAQ::DAQ_FWM not_in_state Included ) then
                if ( DAQ::DAQ_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) DAQ::DAQ_FWM
            insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
            remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) DAQ::DAQ_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( DAQ::DAQ_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( DAQ::DAQ_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) DAQ::DAQ_FWM
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                    remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                    remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) DAQ::DAQ_FWM
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETSTATES
                remove DAQ::DAQ from DAQ_DOMAIN_V2_FWSETACTIONS
                remove DAQ::DAQ_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( DAQ::DAQ_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
                insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( DAQ::DAQ_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
                insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( DAQ::DAQ_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DAQ::DAQ_FWM
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETSTATES
                insert DAQ::DAQ in DAQ_DOMAIN_V2_FWSETACTIONS
                insert DAQ::DAQ_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: DAQ_FWM is_of_class DAQ_FwChildMode_CLASS

class: DATAFLOW_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( DATAFLOW::DATAFLOW_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
                insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
            remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( DATAFLOW::DATAFLOW_FWM in_state Excluded )  do Exclude
        when ( DATAFLOW::DATAFLOW_FWM in_state Ignored )  move_to IGNORED
        when ( DATAFLOW::DATAFLOW_FWM in_state Manual )  move_to MANUAL
        when ( DATAFLOW::DATAFLOW_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM not_in_state Included ) then
                if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                        remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                        remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                        remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
            insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( DATAFLOW::DATAFLOW_FWM not_in_state Included ) then
                if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM not_in_state Included ) then
                if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( DATAFLOW::DATAFLOW_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                        remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                        remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                        remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( DATAFLOW::DATAFLOW_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( DATAFLOW::DATAFLOW_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
              insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
              insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
              insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( DATAFLOW::DATAFLOW_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                 do SetInLocal DATAFLOW::DATAFLOW_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            !move_to Manual
            if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                 do SetInLocal DATAFLOW::DATAFLOW_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
              remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
              remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
              remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                 do SetInLocal DATAFLOW::DATAFLOW_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                 do SetInLocal DATAFLOW::DATAFLOW_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( DATAFLOW::DATAFLOW_FWM in_state Included )  move_to INCLUDED
        when ( DATAFLOW::DATAFLOW_FWM in_state Excluded ) move_to EXCLUDED
        when ( DATAFLOW::DATAFLOW_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
            insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM not_in_state Included ) then
                if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
            remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( DATAFLOW::DATAFLOW_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                    remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                    remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) DATAFLOW::DATAFLOW_FWM
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETSTATES
                remove DATAFLOW::DATAFLOW from DATAFLOWTOP_FWSETACTIONS
                remove DATAFLOW::DATAFLOW_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( DATAFLOW::DATAFLOW_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
                insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( DATAFLOW::DATAFLOW_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
                insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( DATAFLOW::DATAFLOW_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) DATAFLOW::DATAFLOW_FWM
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETSTATES
                insert DATAFLOW::DATAFLOW in DATAFLOWTOP_FWSETACTIONS
                insert DATAFLOW::DATAFLOW_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: DATAFLOW_FWM is_of_class DATAFLOW_FwChildMode_CLASS

class: TFC_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TFC::TFC_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( TFC::TFC_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
                insert TFC::TFC in TFCTOP_FWSETSTATES
                insert TFC::TFC in TFCTOP_FWSETACTIONS
                insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETSTATES
            remove TFC::TFC from TFCTOP_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETACTIONS
            remove TFC::TFC from TFCTOP_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) TFC::TFC_FWM
            remove TFC::TFC from TFCTOP_FWSETSTATES
            remove TFC::TFC from TFCTOP_FWSETACTIONS
            remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( TFC::TFC_FWM in_state Excluded )  do Exclude
        when ( TFC::TFC_FWM in_state Ignored )  move_to IGNORED
        when ( TFC::TFC_FWM in_state Manual )  move_to MANUAL
        when ( TFC::TFC_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( TFC::TFC_FWM not_in_state Included ) then
                if ( TFC::TFC_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) TFC::TFC_FWM
                        remove TFC::TFC from TFCTOP_FWSETSTATES
                        remove TFC::TFC from TFCTOP_FWSETACTIONS
                        remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETSTATES
            remove TFC::TFC from TFCTOP_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETACTIONS
            remove TFC::TFC from TFCTOP_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( TFC::TFC_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( TFC::TFC_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETSTATES
            insert TFC::TFC in TFCTOP_FWSETACTIONS
            insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) TFC::TFC_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( TFC::TFC_FWM not_in_state Included ) then
                if ( TFC::TFC_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( TFC::TFC_FWM not_in_state Included ) then
                if ( TFC::TFC_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( TFC::TFC_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) TFC::TFC_FWM
                        remove TFC::TFC from TFCTOP_FWSETSTATES
                        remove TFC::TFC from TFCTOP_FWSETACTIONS
                        remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( TFC::TFC_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TFC::TFC_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( TFC::TFC_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
              insert TFC::TFC in TFCTOP_FWSETSTATES
              insert TFC::TFC in TFCTOP_FWSETACTIONS
              insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( TFC::TFC_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( TFC::TFC_FWM in_state InManual ) then
                 do SetInLocal TFC::TFC_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETACTIONS
            remove TFC::TFC from TFCTOP_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) TFC::TFC_FWM
            !move_to Manual
            if ( TFC::TFC_FWM in_state InManual ) then
                 do SetInLocal TFC::TFC_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) TFC::TFC_FWM
              remove TFC::TFC from TFCTOP_FWSETSTATES
              remove TFC::TFC from TFCTOP_FWSETACTIONS
              remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( TFC::TFC_FWM in_state InManual ) then
                 do SetInLocal TFC::TFC_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETSTATES
            remove TFC::TFC from TFCTOP_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( TFC::TFC_FWM in_state InManual ) then
                 do SetInLocal TFC::TFC_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( TFC::TFC_FWM in_state Included )  move_to INCLUDED
        when ( TFC::TFC_FWM in_state Excluded ) move_to EXCLUDED
        when ( TFC::TFC_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETSTATES
            insert TFC::TFC in TFCTOP_FWSETACTIONS
            insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( TFC::TFC_FWM not_in_state Included ) then
                if ( TFC::TFC_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) TFC::TFC_FWM
            insert TFC::TFC in TFCTOP_FWSETSTATES
            remove TFC::TFC from TFCTOP_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) TFC::TFC_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( TFC::TFC_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( TFC::TFC_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) TFC::TFC_FWM
                    remove TFC::TFC from TFCTOP_FWSETSTATES
                    remove TFC::TFC from TFCTOP_FWSETACTIONS
                    remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) TFC::TFC_FWM
                remove TFC::TFC from TFCTOP_FWSETSTATES
                remove TFC::TFC from TFCTOP_FWSETACTIONS
                remove TFC::TFC_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( TFC::TFC_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
                insert TFC::TFC in TFCTOP_FWSETSTATES
                insert TFC::TFC in TFCTOP_FWSETACTIONS
                insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( TFC::TFC_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
                insert TFC::TFC in TFCTOP_FWSETSTATES
                insert TFC::TFC in TFCTOP_FWSETACTIONS
                insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( TFC::TFC_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) TFC::TFC_FWM
                insert TFC::TFC in TFCTOP_FWSETSTATES
                insert TFC::TFC in TFCTOP_FWSETACTIONS
                insert TFC::TFC_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: TFC_FWM is_of_class TFC_FwChildMode_CLASS

objectset: FWCHILDMODE_FWSETSTATES is_of_class VOID {DAQ_FWM,
	DATAFLOW_FWM,
	TFC_FWM }
objectset: FWCHILDMODE_FWSETACTIONS is_of_class VOID {DAQ_FWM,
	DATAFLOW_FWM,
	TFC_FWM }

object: DAQ::DAQ is_of_class ASS_DAQ_Domain_v2_CLASS

objectset: DAQ_DOMAIN_V2_FWSETSTATES is_of_class VOID
objectset: DAQ_DOMAIN_V2_FWSETACTIONS is_of_class VOID

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

object: DAQ::DAQ_FWCNM is_of_class ASS_FwChildrenMode_CLASS

object: DATAFLOW::DATAFLOW_FWCNM is_of_class ASS_FwChildrenMode_CLASS

class: FwChildrenMode_CLASS
!panel: FwChildrenMode.pnl
    state: Complete
    !color: _3DFace
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state IncompleteDead ) move_to IncompleteDead
        when (  ( any_in FWCHILDRENMODE_FWSETSTATES in_state DEAD ) and ( any_in FWCHILDMODE_FWSETSTATES in_state MANUAL )  ) move_to IncompleteDead
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state Incomplete )  move_to Incomplete
        when ( any_in FWCHILDMODE_FWSETSTATES not_in_state {Included,ExcludedPerm,LockedOutPerm} )  move_to Incomplete
        when ( any_in FWCHILDRENMODE_FWSETSTATES in_state IncompleteDev )  move_to IncompleteDev
        when ( any_in FWDEVMODE_FWSETSTATES in_state DISABLED )  move_to IncompleteDev
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
        when (  ( all_in FWDEVMODE_FWSETSTATES not_in_state DISABLED ) and
       ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state IncompleteDev )  ) move_to Complete
    state: IncompleteDead
    !color: FwStateAttention3
        when (  (  ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state DEAD ) or ( all_in FWCHILDMODE_FWSETSTATES not_in_state MANUAL )  ) and ( all_in FWCHILDRENMODE_FWSETSTATES not_in_state IncompleteDead )  )  move_to Complete

object: MiniDAQ_FWCNM is_of_class FwChildrenMode_CLASS

object: TFC::TFC_FWCNM is_of_class ASS_FwChildrenMode_CLASS

objectset: FWCHILDRENMODE_FWSETSTATES is_of_class VOID

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

object: DAQ::DAQ_FWM is_of_class ASS_FwMode_CLASS

object: DATAFLOW::DATAFLOW_FWM is_of_class ASS_FwMode_CLASS

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

object: MiniDAQ_FWM is_of_class FwMode_CLASS

object: TFC::TFC_FWM is_of_class ASS_FwMode_CLASS

object: DATAFLOW::DATAFLOW is_of_class ASS_DATAFLOWTop_CLASS

objectset: DATAFLOWTOP_FWSETSTATES is_of_class VOID
objectset: DATAFLOWTOP_FWSETACTIONS is_of_class VOID


object: MiniDAQ is_of_class TOP_MiniDAQTop_CLASS



object: MiniDAQ_RunInfo is_of_class RunInfo_CLASS

objectset: RUNINFO_FWSETSTATES is_of_class VOID {MiniDAQ_RunInfo }
objectset: RUNINFO_FWSETACTIONS is_of_class VOID {MiniDAQ_RunInfo }

class: ASS_TFCTop_CLASS/associated
!panel: TFCTop.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(int STEP_NR = -1, string RUN_TYPE = "PHYSICS", string RUN_INFO_DP = "")	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, string AUTO_STEP_FILE = "")	!visible: 0
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, string AUTO_STEP_FILE = "")	!visible: 1
        action: RESET	!visible: 1
    state: ACTIVE
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: START_TRIGGER(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, int RUN_NUMBER = 0)	!visible: 1
        action: START_RUN	!visible: 0
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, string AUTO_STEP_FILE = "")	!visible: 0
        action: START_SCAN	!visible: 0
        action: STOP_SCAN	!visible: 0
        action: RESET	!visible: 1
    state: PAUSED
    !color: FwStateOKNotPhysics
        action: CONTINUE(int N_TRIGGERS = 0, float STEP_PERIOD = 0.0)	!visible: 1
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: STOP_TRIGGER	!visible: 1
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: STOP_TRIGGER	!visible: 1
        action: PAUSE	!visible: 1
        action: RESET	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1

object: TFC::TFC is_of_class ASS_TFCTop_CLASS

objectset: TFCTOP_FWSETSTATES is_of_class VOID
objectset: TFCTOP_FWSETACTIONS is_of_class VOID

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

object: MiniDAQ_FWDM is_of_class FwDevMode_CLASS

objectset: FWDEVMODE_FWSETSTATES is_of_class VOID {MiniDAQ_FWDM }
objectset: FWDEVMODE_FWSETACTIONS is_of_class VOID {MiniDAQ_FWDM }


objectset: FWCHILDREN_FWSETACTIONS union {DAQ_DOMAIN_V2_FWSETACTIONS,
	DATAFLOWTOP_FWSETACTIONS,
	RUNINFO_FWSETACTIONS,
	TFCTOP_FWSETACTIONS } is_of_class VOID
objectset: FWCHILDREN_FWSETSTATES union {DAQ_DOMAIN_V2_FWSETSTATES,
	DATAFLOWTOP_FWSETSTATES,
	RUNINFO_FWSETSTATES,
	TFCTOP_FWSETSTATES } is_of_class VOID

