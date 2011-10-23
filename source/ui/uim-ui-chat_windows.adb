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
with Qt4.Strings;
with Qt4.Tab_Widgets.Constructors;

with UIM.UI.Chat_Widgets;

with UIM.UI.Chat_Windows.MOC;
pragma Warnings (Off, UIM.UI.Chat_Windows.MOC);
--  Child package MOC must be included in the executable file.

package body UIM.UI.Chat_Windows is

   use type Qt4.Q_Integer;
   use type Qt4.Strings.Q_String;

   ------------------
   --  Add_Dialog  --
   ------------------
   procedure Add_Dialog (Self    : not null access Chat_Window;
                         Message : UIM.Protocols.Messages.Message_Access) is

      Tab : access UIM.UI.Chat_Widgets.Chat_Widget'Class
        := Self.Find_Tab_By_User (Message.Get_Sender);

      Tab_Id : Qt4.Q_Integer;
      pragma Warnings (Off, Tab_Id);

   begin
      if Tab = null then
         Tab := UIM.UI.Chat_Widgets.Create (Message.Get_Sender);

         Tab_Id := Self.Central_Widget.Add_Tab (Tab, Message.Get_Sender.Name);

      end if;

      Tab.Add_Message (Message);
   end Add_Dialog;

   --------------
   --  Create  --
   --------------

   function Create return not null Chat_Window_Access is
      Self : constant Chat_Window_Access := new Chat_Window;

   begin
      --  Initialize director
      Qt4.Main_Windows.Directors.Constructors.Initialize (Self);

      Self.Central_Widget := Qt4.Tab_Widgets.Constructors.Create;

      Self.Set_Central_Widget (Self.Central_Widget);

      return Self;
   end Create;

   ---------------
   --  Get_Tab  --
   ---------------
   function Find_Tab_By_User (Self : not null access Chat_Window;
                              User : UIM.Protocols.Users.User_Access)
      return access UIM.UI.Chat_Widgets.Chat_Widget'Class is

      Tab : access UIM.UI.Chat_Widgets.Chat_Widget'Class;
      UID : constant Qt4.Strings.Q_String := User.Information.Id;

   begin
      if Self.Central_Widget.Count > 0 then
         for J in 0 .. Self.Central_Widget.Count - 1 loop
            Tab := UIM.UI.Chat_Widgets.Chat_Widget'Class
              (Self.Central_Widget.Widget (J).all)'Access;

            if Tab.Get_User.Information.Id = User.Information.Id then

               if Tab.Get_User.Information.Id = UID then
                  --  Self.D.Log ("User found : " & UID.To_Ucs_4);
                  --  Self.D.Log ("ID : " & UID.To_Ucs_4);

                  --  If user found we adding message to chat window
                  --  and activate tab, behaviour should be configurable.
                  return UIM.UI.Chat_Widgets.Chat_Widget'Class
                    (Self.Central_Widget.Widget (J).all)'Access;
               end if;
            end if;
         end loop;
      end if;

      return null;
   end Find_Tab_By_User;

end UIM.UI.Chat_Windows;
