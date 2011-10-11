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
with Qt4.Widgets.Constructors;

with UIM.UI.Chat_Windows.MOC;
pragma Warnings (Off, UIM.UI.Chat_Windows.MOC);
--  Child package MOC must be included in the executable file.

package body UIM.UI.Chat_Windows is

   function Create return not null Chat_Window_Access is
      Self : constant Chat_Window_Access := new Chat_Window;

   begin
      --  Initialize director
      Qt4.Main_Windows.Directors.Constructors.Initialize (Self);

      Self.Central_Widget := Qt4.Widgets.Constructors.Create;

      Self.Set_Central_Widget (Self.Central_Widget);

      return Self;
   end Create;

   --  procedure Create_Actions (Self : not null access Main_Window'Class);

   --  procedure Create_Main_Menu (Self : not null access Main_Window'Class);

   --  Slots

   --  Shows user info about selected user in Contact List
   --  procedure Show_User_Info (Self  : not null access Main_Window);
   --  pragma Q_Slot (Show_User_Info);

   --  procedure Show_Settings_Slot (Self : not null access Main_Window);
   --  pragma Q_Slot (Show_Settings_Slot);

   --  procedure Add_Group_Slot (Self : not null access Main_Window);
   --  pragma Q_Slot (Add_Group_Slot);

   --  procedure Add_User_Slot (Self : not null access Main_Window);
   --  pragma Q_Slot (Add_User_Slot);

   --  procedure Find_Contact_Slot (Self  : not null access Main_Window);
   --  pragma Q_Slot (Find_Contact_Slot);

   --  procedure Save_Settings_Slot (Self  : not null access Main_Window);
   --  pragma Q_Slot (Save_Settings_Slot);

   --  procedure Load_Settings_Slot (Self  : not null access Main_Window);
   --  pragma Q_Slot (Load_Settings_Slot);

   --  procedure Join_Chat_Slot (Self  : not null access Main_Window);
   --  pragma Q_Slot (Join_Chat_Slot);

   --  Events
   --  procedure Close_Event
   --    (Self  : not null access Main_Window;
   --     Event : not null access Qt4.Close_Events.Q_Close_Event'Class);

end UIM.UI.Chat_Windows;
