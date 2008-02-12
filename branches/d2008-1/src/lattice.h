/***************************************************************************
 *
 *  lattice.h
 *
 *  $Id: lattice.h,v 1.5.4.2 2008-02-12 17:15:47 kevin Exp $
 *
 *  Kevin Stratford (kevin@epcc.ed.ac.uk)
 *
 ***************************************************************************/

#ifndef _LATTICE_H_
#define _LATTICE_H_

void LATT_allocate_force(const int);
void latt_allocate_velocity(const int);
void set_force_at_site(const int, double []);
void add_force_at_site(const int, double []);
void get_velocity_at_lattice(const int, double []);

struct vector {double c[3];};

#endif /* _LATTICE_H_ */
