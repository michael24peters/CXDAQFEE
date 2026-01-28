class: SODIN_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( SODIN::SODIN_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( SODIN::SODIN_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
                insert SODIN::SODIN in SODINTYPE_FWSETSTATES
                insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
                insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETSTATES
            remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
            remove SODIN::SODIN from SODINTYPE_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
            remove SODIN::SODIN from SODINTYPE_FWSETSTATES
            remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
            remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( SODIN::SODIN_FWM in_state Excluded )  do Exclude
        when ( SODIN::SODIN_FWM in_state Ignored )  move_to IGNORED
        when ( SODIN::SODIN_FWM in_state Manual )  move_to MANUAL
        when ( SODIN::SODIN_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( SODIN::SODIN_FWM not_in_state Included ) then
                if ( SODIN::SODIN_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                        remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                        remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                        remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETSTATES
            remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
            remove SODIN::SODIN from SODINTYPE_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( SODIN::SODIN_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( SODIN::SODIN_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETSTATES
            insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
            insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) SODIN::SODIN_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( SODIN::SODIN_FWM not_in_state Included ) then
                if ( SODIN::SODIN_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( SODIN::SODIN_FWM not_in_state Included ) then
                if ( SODIN::SODIN_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( SODIN::SODIN_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                        remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                        remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                        remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( SODIN::SODIN_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( SODIN::SODIN_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( SODIN::SODIN_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
              insert SODIN::SODIN in SODINTYPE_FWSETSTATES
              insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
              insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( SODIN::SODIN_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( SODIN::SODIN_FWM in_state InManual ) then
                 do SetInLocal SODIN::SODIN_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
            remove SODIN::SODIN from SODINTYPE_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) SODIN::SODIN_FWM
            !move_to Manual
            if ( SODIN::SODIN_FWM in_state InManual ) then
                 do SetInLocal SODIN::SODIN_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) SODIN::SODIN_FWM
              remove SODIN::SODIN from SODINTYPE_FWSETSTATES
              remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
              remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( SODIN::SODIN_FWM in_state InManual ) then
                 do SetInLocal SODIN::SODIN_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETSTATES
            remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( SODIN::SODIN_FWM in_state InManual ) then
                 do SetInLocal SODIN::SODIN_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( SODIN::SODIN_FWM in_state Included )  move_to INCLUDED
        when ( SODIN::SODIN_FWM in_state Excluded ) move_to EXCLUDED
        when ( SODIN::SODIN_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETSTATES
            insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
            insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( SODIN::SODIN_FWM not_in_state Included ) then
                if ( SODIN::SODIN_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) SODIN::SODIN_FWM
            insert SODIN::SODIN in SODINTYPE_FWSETSTATES
            remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) SODIN::SODIN_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( SODIN::SODIN_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( SODIN::SODIN_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) SODIN::SODIN_FWM
                    remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                    remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                    remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) SODIN::SODIN_FWM
                remove SODIN::SODIN from SODINTYPE_FWSETSTATES
                remove SODIN::SODIN from SODINTYPE_FWSETACTIONS
                remove SODIN::SODIN_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( SODIN::SODIN_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
                insert SODIN::SODIN in SODINTYPE_FWSETSTATES
                insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
                insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( SODIN::SODIN_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
                insert SODIN::SODIN in SODINTYPE_FWSETSTATES
                insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
                insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( SODIN::SODIN_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SODIN::SODIN_FWM
                insert SODIN::SODIN in SODINTYPE_FWSETSTATES
                insert SODIN::SODIN in SODINTYPE_FWSETACTIONS
                insert SODIN::SODIN_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: SODIN_FWM is_of_class SODIN_FwChildMode_CLASS

class: SOL40_FwChildMode_CLASS

!panel: FwChildMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( SOL40::SOL40_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( SOL40::SOL40_FWM not_in_state {Excluded, Manual} ) then
            !    else
                    move_to Excluded
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
                insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
                insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
                insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: Manual	!visible: 0
            do Manual SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
            remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
            move_to Manual
        action: Ignore	!visible: 0
            do Ignore SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
            remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
            move_to Ignored
        action: LockOut	!visible: 1
            move_to LockedOut
        action: Exclude(string OWNER = "")	!visible: 1
            do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
            remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
            remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
            remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            move_to Excluded
        action: ExcludePerm(string OWNER = "")	!visible: 0
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 0
            move_to LockedOut
    state: Included
    !color: FwStateOKPhysics
        when ( SOL40::SOL40_FWM in_state Excluded )  do Exclude
        when ( SOL40::SOL40_FWM in_state Ignored )  move_to IGNORED
        when ( SOL40::SOL40_FWM in_state Manual )  move_to MANUAL
        when ( SOL40::SOL40_FWM in_state Dead )  do Manual
        action: Exclude(string OWNER = "")	!visible: 1
            if ( SOL40::SOL40_FWM not_in_state Included ) then
                if ( SOL40::SOL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                        do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                        remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                        remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                        remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !       else
            !            move_to Included
            !        endif
                endif
            else
                do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 1
            do Manual(OWNER=OWNER) SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
            remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 1
            do Ignore(OWNER=OWNER) SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
            remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( SOL40::SOL40_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( SOL40::SOL40_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
            insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
            insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) SOL40::SOL40_FWM
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
        action: ExcludePerm(string OWNER = "")	!visible: 0
            if ( SOL40::SOL40_FWM not_in_state Included ) then
                if ( SOL40::SOL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to ExcludedPerm
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
            if ( SOL40::SOL40_FWM not_in_state Included ) then
                if ( SOL40::SOL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    if ( SOL40::SOL40_FWM in_state Dead ) then
                        do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                        remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                        remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                        remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                   else
                        move_to Included
                    endif
                endif
            else
                do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to LockedOut
    state: Manual
    !color: FwStateOKNotPhysics
        when ( SOL40::SOL40_FWM in_state Included )  move_to EXCLUDED
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( SOL40::SOL40_FWM in_state Dead ) then
              move_to Manual
            endif
            if ( SOL40::SOL40_FWM not_in_state InManual ) then
              do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
              insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
              insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
              insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
              if ( SOL40::SOL40_FWM in_state Included ) then
                move_to Included
              endif
            move_to Manual
        action: Exclude(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( SOL40::SOL40_FWM in_state InManual ) then
                 do SetInLocal SOL40::SOL40_FWM
            endif
            move_to Excluded
        action: Ignore	!visible: 0
            do Ignore SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
            remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) SOL40::SOL40_FWM
            !move_to Manual
            if ( SOL40::SOL40_FWM in_state InManual ) then
                 do SetInLocal SOL40::SOL40_FWM
            endif
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 1
            !    else
            !        move_to Included
            !    endif
            !else
            !endif
              do ExcludeAll(OWNER=OWNER) SOL40::SOL40_FWM
              remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
              remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
              remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !endif
            !move_to Manual
            if ( SOL40::SOL40_FWM in_state InManual ) then
                 do SetInLocal SOL40::SOL40_FWM
            endif
            move_to Excluded
        action: Manual	!visible: 0
            do Manual SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
            remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
            move_to Manual
        action: Exclude&LockOut(string OWNER = "")	!visible: 1
                do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            !    move_to Excluded
            !endif
            !    else
            !    endif
            !else
            !endif
            !    move_to Excluded
            !endif
            !move_to Manual
            if ( SOL40::SOL40_FWM in_state InManual ) then
                 do SetInLocal SOL40::SOL40_FWM
            endif
            move_to LockedOut
    state: Ignored
    !color: FwStateOKNotPhysics
        when ( SOL40::SOL40_FWM in_state Included )  move_to INCLUDED
        when ( SOL40::SOL40_FWM in_state Excluded ) move_to EXCLUDED
        when ( SOL40::SOL40_FWM in_state Dead )  do Exclude
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
            insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
            insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 1
            if ( SOL40::SOL40_FWM not_in_state Included ) then
                if ( SOL40::SOL40_FWM in_state InManual ) then
                    do Release(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                endif
            else
                do Exclude(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            do Manual(OWNER=OWNER) SOL40::SOL40_FWM
            insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
            remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            do SetMode(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
        action: Free(string OWNER = "")	!visible: 0
            do Free(OWNER=OWNER) SOL40::SOL40_FWM
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 1
            if ( SOL40::SOL40_FWM not_in_state {Included,Ignored,Manual} ) then
                if ( SOL40::SOL40_FWM in_state InManual ) then
                    do ReleaseAll(OWNER=OWNER) SOL40::SOL40_FWM
                    remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                    remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                    remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
                else
                    move_to Included
                endif
            else
                do ExcludeAll(OWNER=OWNER) SOL40::SOL40_FWM
                remove SOL40::SOL40 from STFCTYPE_FWSETSTATES
                remove SOL40::SOL40 from STFCTYPE_FWSETACTIONS
                remove SOL40::SOL40_FWCNM from FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Excluded
    state: LockedOut
    !color: FwStateOKNotPhysics
        action: UnLockOut	!visible: 1
            move_to Excluded
        action: UnLockOut&Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            if ( SOL40::SOL40_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOut
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
                insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
                insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
                insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( SOL40::SOL40_FWM not_in_state {Excluded, Manual} ) then
                move_to ExcludedPerm
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
                insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
                insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
                insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
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
            if ( SOL40::SOL40_FWM not_in_state Excluded ) then
            !    else
                    move_to LockedOutPerm
            !    endif
            else
                do Include(OWNER=OWNER,EXCLUSIVE=EXCLUSIVE) SOL40::SOL40_FWM
                insert SOL40::SOL40 in STFCTYPE_FWSETSTATES
                insert SOL40::SOL40 in STFCTYPE_FWSETACTIONS
                insert SOL40::SOL40_FWCNM in FWCHILDRENMODE_FWSETSTATES
            endif
            move_to Included
        action: LockOut	!visible: 0
            move_to LockedOut

object: SOL40_FWM is_of_class SOL40_FwChildMode_CLASS

objectset: FWCHILDMODE_FWSETSTATES is_of_class VOID {SODIN_FWM,
	SOL40_FWM }
objectset: FWCHILDMODE_FWSETACTIONS is_of_class VOID {SODIN_FWM,
	SOL40_FWM }

class: ASS_SODINType_CLASS/associated
!panel: SODINType.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(int STEP_NR = -1, string RUN_TYPE = "PHYSICS")	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0)	!visible: 0
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, int STEP_PERIOD = 0)	!visible: 1
        action: RESET	!visible: 1
    state: ACTIVE
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: START_TRIGGER(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, int RUN_NUMBER = 0)	!visible: 1
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, int STEP_PERIOD = 0)	!visible: 0
        action: START_RUN	!visible: 0
        action: START_SCAN	!visible: 0
        action: STOP_SCAN	!visible: 0
        action: RESET	!visible: 1
    state: PAUSED
    !color: FwStateOKNotPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: CONTINUE(int N_TRIGGERS = 0, float STEP_PERIOD = 0.0)	!visible: 1
        action: STOP_TRIGGER	!visible: 1
        action: RESET	!visible: 1
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: PAUSE	!visible: 1
        action: STOP_TRIGGER	!visible: 1
        action: STOP_SCAN	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1

object: SODIN::SODIN is_of_class ASS_SODINType_CLASS

objectset: SODINTYPE_FWSETSTATES is_of_class VOID
objectset: SODINTYPE_FWSETACTIONS is_of_class VOID

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

object: SODIN::SODIN_FWCNM is_of_class ASS_FwChildrenMode_CLASS

object: SOL40::SOL40_FWCNM is_of_class ASS_FwChildrenMode_CLASS

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

object: TFC_FWCNM is_of_class FwChildrenMode_CLASS

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

object: SODIN::SODIN_FWM is_of_class ASS_FwMode_CLASS

object: SOL40::SOL40_FWM is_of_class ASS_FwMode_CLASS

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

object: TFC_FWM is_of_class FwMode_CLASS

class: ASS_STFCType_CLASS/associated
!panel: STFCType.pnl
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE(string RUN_TYPE = "PHYSICS", string RUN_INFO_DP = "")	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START_RUN(int N_TRIGGERS = 0, string AUTO_STEP_FILE = "")	!visible: 0
        action: START(int N_TRIGGERS = 0, string AUTO_STEP_FILE = "")	!visible: 1
        action: RESET	!visible: 1
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP_RUN	!visible: 0
        action: STOP	!visible: 1
        action: RESET	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1

object: SOL40::SOL40 is_of_class ASS_STFCType_CLASS

objectset: STFCTYPE_FWSETSTATES is_of_class VOID
objectset: STFCTYPE_FWSETACTIONS is_of_class VOID

class: TOP_TFCTop_CLASS
!panel: TFCTop.pnl
    state: NOT_READY
    !color: FwStateAttention1
        when ( any_in FWCHILDREN_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( all_in FWCHILDREN_FWSETSTATES in_state READY ) move_to READY
        when ( all_in FWCHILDREN_FWSETSTATES in_state RUNNING )  move_to RUNNING
        when (  ( all_in SODINTYPE_FWSETSTATES in_state ACTIVE ) and
       ( all_in STFCTYPE_FWSETSTATES in_state READY )  )  move_to READY
        when (  ( all_in SODINTYPE_FWSETSTATES in_state ACTIVE ) and
       ( all_in STFCTYPE_FWSETSTATES in_state RUNNING )  )  move_to ACTIVE
        when ( any_in FWCHILDREN_FWSETSTATES in_state PAUSED ) move_to PAUSED
        action: CONFIGURE(int STEP_NR = -1, string RUN_TYPE = "PHYSICS", string RUN_INFO_DP = "")	!visible: 1
            do CONFIGURE(STEP_NR=STEP_NR,RUN_TYPE=RUN_TYPE,RUN_INFO_DP=RUN_INFO_DP) all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to NOT_READY
            endif
            move_to READY
        action: RESET	!visible: 1
            do RESET all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: READY
    !color: FwStateOKNotPhysics
        when ( any_in FWCHILDREN_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( any_in FWCHILDREN_FWSETSTATES in_state NOT_READY ) move_to NOT_READY
        when ( all_in FWCHILDREN_FWSETSTATES in_state RUNNING )  move_to RUNNING
        when (  ( all_in SODINTYPE_FWSETSTATES in_state ACTIVE ) and
       ( all_in STFCTYPE_FWSETSTATES in_state RUNNING )  )  move_to ACTIVE
        when (  ( all_in SODINTYPE_FWSETSTATES in_state PAUSED ) and
       ( all_in STFCTYPE_FWSETSTATES in_state RUNNING )  )  move_to PAUSED
        when ( any_in FWCHILDREN_FWSETSTATES in_state PAUSED ) move_to PAUSED
        action: START_RUN(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, string AUTO_STEP_FILE = "")	!visible: 0
            do START_RUN(N_TRIGGERS=N_TRIGGERS, STEP_NR=STEP_NR, STEP_PERIOD=STEP_PERIOD, AUTO_STEP_FILE=AUTO_STEP_FILE) all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state {ACTIVE,RUNNING} ) then
                move_to READY
            endif
            move_to ACTIVE
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, string AUTO_STEP_FILE = "")	!visible: 1
            do START(N_TRIGGERS=N_TRIGGERS, STEP_NR=STEP_NR, STEP_PERIOD=STEP_PERIOD, AUTO_STEP_FILE=AUTO_STEP_FILE) all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state {ACTIVE,RUNNING} ) then
                move_to READY
            endif
            move_to ACTIVE
        action: RESET	!visible: 1
            do RESET all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: ACTIVE
    !color: FwStateOKNotPhysics
        when ( any_in FWCHILDREN_FWSETSTATES in_state ERROR )  move_to ERROR
        when ( any_in FWCHILDREN_FWSETSTATES in_state NOT_READY )  move_to NOT_READY
        when ( any_in FWCHILDREN_FWSETSTATES in_state READY )  move_to READY
        when ( any_in FWCHILDREN_FWSETSTATES in_state PAUSED ) move_to PAUSED
        when ( all_in FWCHILDREN_FWSETSTATES in_state RUNNING )  move_to RUNNING
        action: STOP_RUN	!visible: 0
            do STOP_RUN all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: STOP	!visible: 1
            do STOP all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: START_TRIGGER(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, int RUN_NUMBER = 0)	!visible: 1
            do START_TRIGGER(N_TRIGGERS=N_TRIGGERS, STEP_NR=STEP_NR, STEP_PERIOD=STEP_PERIOD, RUN_NUMBER=RUN_NUMBER) all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state RUNNING ) then
                move_to ACTIVE
            endif
            move_to RUNNING
        action: START_RUN	!visible: 0
            do START_RUN all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state RUNNING ) then
                move_to READY
            endif
            move_to RUNNING
        action: START(int N_TRIGGERS = 0, int STEP_NR = 0, float STEP_PERIOD = 0.0, string AUTO_STEP_FILE = "")	!visible: 0
            do START(N_TRIGGERS=N_TRIGGERS, STEP_NR=STEP_NR, STEP_PERIOD=STEP_PERIOD, AUTO_STEP_FILE=AUTO_STEP_FILE) all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state {ACTIVE,RUNNING} ) then
                move_to READY
            endif
            move_to ACTIVE
        action: START_SCAN	!visible: 0
            do START_SCAN all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: STOP_SCAN	!visible: 0
            do STOP_SCAN all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: RESET	!visible: 1
            do RESET all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: PAUSED
    !color: FwStateOKNotPhysics
        when ( any_in FWCHILDREN_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( any_in FWCHILDREN_FWSETSTATES in_state NOT_READY ) move_to NOT_READY
        when ( any_in FWCHILDREN_FWSETSTATES in_state ACTIVE )  move_to ACTIVE
        when ( any_in FWCHILDREN_FWSETSTATES in_state READY ) move_to READY
        when ( all_in FWCHILDREN_FWSETSTATES in_state RUNNING )  move_to RUNNING
        action: CONTINUE(int N_TRIGGERS = 0, float STEP_PERIOD = 0.0)	!visible: 1
            do CONTINUE(N_TRIGGERS=N_TRIGGERS, STEP_PERIOD=STEP_PERIOD) all_in FWCHILDREN_FWSETACTIONS
            if ( any_in FWCHILDREN_FWSETSTATES not_in_state RUNNING ) then
                move_to PAUSED
            endif
            move_to RUNNING
        action: STOP_RUN	!visible: 0
            do STOP_RUN all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to PAUSED
            endif
            move_to READY
        action: STOP	!visible: 1
            do STOP all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: STOP_TRIGGER	!visible: 1
            do STOP_TRIGGER all_in FWCHILDREN_FWSETACTIONS
            if ( any_in FWCHILDREN_FWSETSTATES not_in_state ACTIVE ) then
                move_to RUNNING
            endif
            move_to ACTIVE
    state: RUNNING
    !color: FwStateOKPhysics
        when ( any_in FWCHILDREN_FWSETSTATES in_state ERROR ) move_to ERROR
        when ( any_in FWCHILDREN_FWSETSTATES in_state NOT_READY ) move_to NOT_READY
        when ( any_in FWCHILDREN_FWSETSTATES in_state READY ) move_to READY
        when ( any_in FWCHILDREN_FWSETSTATES in_state ACTIVE ) move_to ACTIVE
        when ( any_in FWCHILDREN_FWSETSTATES in_state PAUSED ) move_to PAUSED
        action: STOP_RUN	!visible: 0
            do STOP_RUN all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: STOP	!visible: 1
            do STOP all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state READY ) then
                move_to RUNNING
            endif
            move_to READY
        action: STOP_TRIGGER	!visible: 1
            do STOP_TRIGGER all_in FWCHILDREN_FWSETACTIONS
            if ( any_in FWCHILDREN_FWSETSTATES not_in_state ACTIVE ) then
                move_to RUNNING
            endif
            move_to ACTIVE
        action: PAUSE	!visible: 1
            do PAUSE all_in FWCHILDREN_FWSETACTIONS
            if ( any_in SODINTYPE_FWSETSTATES not_in_state PAUSED ) then
                move_to RUNNING
            endif
            move_to PAUSED
        action: RESET	!visible: 1
            do RESET all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state NOT_READY ) then
                move_to READY
            endif
            move_to NOT_READY
    state: ERROR
    !color: FwStateAttention3
        when ( all_in FWCHILDREN_FWSETSTATES not_in_state ERROR ) move_to NOT_READY
        action: RECOVER	!visible: 1
            do RECOVER all_in FWCHILDREN_FWSETACTIONS
            if ( all_in FWCHILDREN_FWSETSTATES not_in_state NOT_READY ) then
            	move_to ERROR
            endif
            move_to NOT_READY

object: TFC is_of_class TOP_TFCTop_CLASS


objectset: FWCHILDREN_FWSETACTIONS union {SODINTYPE_FWSETACTIONS,
	STFCTYPE_FWSETACTIONS } is_of_class VOID
objectset: FWCHILDREN_FWSETSTATES union {SODINTYPE_FWSETSTATES,
	STFCTYPE_FWSETSTATES } is_of_class VOID

