/*
 * 07/24/2002 - 20:37:20
 *
 * FlashThread.java
 * Copyright (C) 2002 Michael Bommer
 * m_bommer@yahoo.de
 * www.well-of-souls.com/tower
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

package com.michaelbommer.darktower;

import java.lang.Thread;

public class FlashThread extends Thread
{
	private DarkTower darkTower = null;
	private DarkTowerPanel darkTowerPanel = null;

	public FlashThread(DarkTower darkTower)
	{
		this.darkTower = darkTower;
		this.darkTowerPanel = darkTower.getDarkTowerPanel();
	}

	public void run()
	{
		try
		{
			while ( !interrupted() )
			{
				darkTowerPanel.repaint();
				sleep(300);
			}
		}
		catch ( InterruptedException e )
		{}
	}
}
