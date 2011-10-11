------------------------------------------------------------------------------
--                                                                          --
--                               UIM Project                                --
--                                                                          --
--                Multi protocol instant messenger for unix                 --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Alexander Basov <coopht@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Alexander Basov, IE nor the names of its      --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Qt4.Combo_Boxes;
with Qt4.Model_Indices;
with Qt4.Tool_Buttons;
with Qt4.Tree_Views;
with Qt4.Variants;
with Qt4.Widgets;
private with Qt4.Widgets.Directors;

with UIM.Protocols.Common;

package UIM.UI.Proto_Widgets is

   type Proto_Widget is limited new Qt4.Widgets.Q_Widget with private;

   type Proto_Widget_Access is access all Proto_Widget'Class;

   function Create
    (Proto : not null access UIM.Protocols.Common.Common_Protocol'Class)
      return not null Proto_Widget_Access;

   function Get_Proto (Self : not null access Proto_Widget)
      return not null access UIM.Protocols.Common.Common_Protocol'Class;
   --  returns protocol, associated with tab

   procedure Show_User_Info_Slot (Self  : not null access Proto_Widget);
   pragma Q_Slot (Show_User_Info_Slot);
   --  Shows user info about selected user in Contact List

private

   type Proto_Widget is new Qt4.Widgets.Directors.Q_Widget_Director with
      record
         Status_Box   : Qt4.Combo_Boxes.Q_Combo_Box_Access;
         Proto        : --  Protocol, which is associated with current tab
           access UIM.Protocols.Common.Common_Protocol'Class;
         Contact_List : Qt4.Tree_Views.Q_Tree_View_Access;
         Menu_Button  : Qt4.Tool_Buttons.Q_Tool_Button_Access;
      end record;

   procedure Status_Box_Activated (Self  : not null access Proto_Widget;
                                   Index : Qt4.Q_Integer);
   pragma Q_Slot (Status_Box_Activated, "statusBoxActivated(int)");

   procedure CL_Item_Activated (Self  : not null access Proto_Widget;
                                Index : Qt4.Model_Indices.Q_Model_Index);
   pragma Q_Slot (CL_Item_Activated, "clItemActivated(QModelIndex)");

   procedure CL_Context_Menu_Slot (Self : not null access Proto_Widget);
   pragma Q_Slot (CL_Context_Menu_Slot);

   procedure Menu_Button_Slot (Self : not null access Proto_Widget);
   pragma Q_Slot (Menu_Button_Slot);

end UIM.UI.Proto_Widgets;
