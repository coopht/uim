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
with Qt4.H_Box_Layouts.Constructors;
with Qt4.V_Box_Layouts.Constructors;
with Qt4.Widgets.Directors.Constructors;

package UIM.UI.Chat_Widgets is

   --------------
   --  Create  --
   --------------
   function Create return not null access Chat_Widget'Class
   is
      Self : constant Chat_Widget_Access := new Chat_Widget;

      HLayout : constant not null access Qt4.H_Box_Layouts.Q_H_BOX_Layout'Class
        := Qt4.H_Box_Layouts.Constructors.Create;

      VLayout : constant not null access Qt4.V_BOX_Layouts.Q_V_BOX_Layout'Class
        := Qt4.V_BOX_Layouts.Constructors.Create;

   begin
      Qt4.Widgets.Directors.Constructors.Initialize (Self);

      Self.History_View := Qt4.Text_Edits.Constructors.Create;
      Self.Msg_Edit := Qt4.Text_Edits.Constructors.Create;
      VLayout.Add_Widget (Self.History_View);
      VLayout.Add_Widget (Self.Msg_Edit);

      Self.Members := Qt4.List_Widgets.Constructors.Create;
      --  Self.Members.Set_Visible (False);
      HLayout.Add_Layout (VLayout);
      HLayout.Add_Widget (Qt4.Splitters.Constructors.Create);
      HLayout.Add_Widget (Self.Members);

      Self.Set_Layout (HLayout);
      return Self;
   end Create;


end UIM.UI.Chat_Widgets;
