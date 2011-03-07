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
--  * Neither the name of the Alexander Basov, IE nor the names of its        --
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

package body UIM.Protocols.Statuses is

   ----------
   --  Id  --
   ----------

   function Id (Self : Status) return Integer is
   begin
      return Self.Status_Id;
   end Id;

   ------------
   --  Name  --
   ------------

   function Name (Self : Status) return League.Strings.Universal_String is
   begin
      return Self.Status_Name;
   end Name;

   --------------
   --  Set_Id  --
   --------------

   procedure Set_Id (Self : in out Status; Id : Integer) is
   begin
      Self.Status_Id := Id;
   end Set_Id;

   ----------------
   --  Set_Name  --
   ----------------

   procedure Set_Name
     (Self : in out Status;
      Name : League.Strings.Universal_String) is
   begin
      Self.Status_Name := Name;
   end Set_Name;

   -----------------
   --  Set_State  --
   -----------------

   procedure Set_State (Self : in out Status;
                        Name : League.Strings.Universal_String) is
   begin
      Self.State := Name;
   end Set_State;

   -------------
   --  State  --
   -------------

   function State (Self : Status) return League.Strings.Universal_String is
   begin
      return Self.State;
   end State;

end UIM.Protocols.Statuses;
